{
  pkgs,
  lib,
  config,
  ...
}: let
  docker = "${pkgs.docker}/bin/docker";
  traefikImage = "traefik:v3.6.25";
in {
  # Declarative equivalent of https://dokploy.com/install.sh.
  # Each step is idempotent; Dokploy updates itself from its UI afterwards.
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /etc/dokploy 0777 root root - -"
    ];

    systemd.services.dokploy-setup = {
      description = "Set up Dokploy on Docker Swarm";
      after = ["docker.service" "network-online.target"];
      requires = ["docker.service"];
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      path = [pkgs.openssl];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        if [ "$(${docker} info --format '{{.Swarm.LocalNodeState}}')" != "active" ]; then
          ${docker} swarm init --advertise-addr 127.0.0.1
        fi

        ${docker} network inspect dokploy-network >/dev/null 2>&1 \
          || ${docker} network create --driver overlay --attachable dokploy-network

        ${docker} secret inspect dokploy_postgres_password >/dev/null 2>&1 \
          || openssl rand -hex 16 | ${docker} secret create dokploy_postgres_password -
        ${docker} secret inspect dokploy_auth_secret >/dev/null 2>&1 \
          || openssl rand -hex 32 | ${docker} secret create dokploy_auth_secret -

        ${docker} service inspect dokploy-postgres >/dev/null 2>&1 \
          || ${docker} service create \
            --name dokploy-postgres \
            --constraint 'node.role==manager' \
            --network dokploy-network \
            --env POSTGRES_USER=dokploy \
            --env POSTGRES_DB=dokploy \
            --secret source=dokploy_postgres_password,target=/run/secrets/postgres_password \
            --env POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password \
            --mount type=volume,source=dokploy-postgres,target=/var/lib/postgresql/data \
            postgres:16

        ${docker} service inspect dokploy >/dev/null 2>&1 \
          || ${docker} service create \
            --name dokploy \
            --replicas 1 \
            --network dokploy-network \
            --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
            --mount type=bind,source=/etc/dokploy,target=/etc/dokploy \
            --mount type=volume,source=dokploy,target=/root/.docker \
            --secret source=dokploy_postgres_password,target=/run/secrets/postgres_password \
            --secret source=dokploy_auth_secret,target=/run/secrets/dokploy_auth_secret \
            --publish published=3000,target=3000,mode=host \
            --update-parallelism 1 \
            --update-order stop-first \
            --constraint 'node.role == manager' \
            -e POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password \
            -e BETTER_AUTH_SECRET_FILE=/run/secrets/dokploy_auth_secret \
            dokploy/dokploy:latest

        # Dokploy writes the Traefik config on its first start.
        for _ in $(seq 60); do
          [ -f /etc/dokploy/traefik/traefik.yml ] && break
          sleep 5
        done

        if ${docker} container inspect dokploy-traefik >/dev/null 2>&1; then
          ${docker} start dokploy-traefik
        else
          ${docker} run -d \
            --name dokploy-traefik \
            --restart always \
            --network dokploy-network \
            -v /etc/dokploy/traefik/traefik.yml:/etc/traefik/traefik.yml \
            -v /etc/dokploy/traefik/dynamic:/etc/dokploy/traefik/dynamic \
            -v /var/run/docker.sock:/var/run/docker.sock:ro \
            -p 80:80/tcp \
            -p 443:443/tcp \
            -p 443:443/udp \
            ${traefikImage}
        fi
      '';
    };

    # Dokploy dashboard. Also reachable through Tailscale.
    networking.firewall.allowedTCPPorts = [3000];
  };
}
