{
  inputs,
  pkgs,
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /srv/data/freshrss/config 0755 root root - -"
      "d /srv/data/rss-bridge/config 0755 root root - -"
      "d /srv/data/rsshub/data 0755 root root - -"
    ];

    virtualisation.oci-containers.containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss:version-1.30.4";
        volumes = [
          "/srv/data/freshrss/config:/config"
        ];
        environment = {
          "TZ" = vars.timeZone;
          "PUID" = "1000";
          "PGID" = "1000";
          "CRON_MIN" = "1,16,31,46";
          # 1.30.0+ blocks requests to private networks by default.
          # rss-generator is deployed by Dokploy and published on the host's port 4000.
          # Reach it via the docker0 gateway IP: FreshRSS resolves hosts with DNS only,
          # so /etc/hosts entries such as host.docker.internal are rejected.
          "INTERNAL_HOST_ALLOWLIST" = "rss-bridge:80 rsshub:1200 172.17.0.1:4000";
        };
        ports = ["8080:80"];
        extraOptions = [
          "--network=rss-net"
        ];
      };

      rss-bridge = {
        image = "rssbridge/rss-bridge:latest";
        # `latest` is a moving tag; re-pull on start so security rebuilds are picked up
        # (Docker has no `newer` policy; that one is podman-only)
        pull = "always";
        volumes = [
          "/srv/data/rss-bridge/config:/config"
        ];
        ports = ["3001:80"];
        extraOptions = [
          "--network=rss-net"
        ];
      };

      rsshub = {
        image = "diygod/rsshub:chromium-bundled";
        environment = {
          "NODE_ENV" = "production";
          "CACHE_TYPE" = "redis";
          "REDIS_URL" = "redis://redis:6379/";
          "PUPPETEER_WS_ENDPOINT" = "ws://browserless:3000";
        };
        ports = ["1200:1200"];
        dependsOn = ["redis" "browserless"];
        extraOptions = [
          "--network=rss-net"
        ];
        environmentFiles = [config.age.secrets.rsshub.path];
      };

      browserless = {
        image = "browserless/chrome";
        extraOptions = [
          "--network=rss-net"
        ];
      };

      redis = {
        image = "redis:alpine";
        volumes = [
          "/srv/data/rsshub/data:/data"
        ];
        extraOptions = [
          "--network=rss-net"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [
      8080 # FreshRSS
      3001 # RSS-Bridge
    ];

    systemd.services."create-docker-rss-network" = {
      after = ["docker.service"];
      requires = ["docker.service"];
      before = map (name: "docker-${name}.service") ["freshrss" "rss-bridge" "rsshub" "browserless" "redis"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.docker}/bin/docker network rm -f rss-net";
      };
      script = ''
        ${pkgs.docker}/bin/docker network inspect rss-net >/dev/null 2>&1 \
          || ${pkgs.docker}/bin/docker network create rss-net
      '';
      wantedBy = [
        "multi-user.target"
      ];
    };

    age.secrets = {
      rsshub = {
        file = "${inputs.secrets}/rsshub.age";
        mode = "600";
      };
    };
  };
}
