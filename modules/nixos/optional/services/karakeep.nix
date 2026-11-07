{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /srv/data/karakeep/data 0755 root root - -"
      "d /srv/data/karakeep/meili 0755 root root - -"
    ];

    systemd.services."create-docker-karakeep-network" = {
      after = ["docker.service"];
      requires = ["docker.service"];
      before = map (name: "docker-${name}.service") ["karakeep" "meilisearch" "chrome"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.docker}/bin/docker network rm -f karakeep-net";
      };
      script = ''
        ${pkgs.docker}/bin/docker network inspect karakeep-net >/dev/null 2>&1 \
          || ${pkgs.docker}/bin/docker network create karakeep-net
      '';
      wantedBy = ["multi-user.target"];
    };

    virtualisation.oci-containers.containers = {
      karakeep = {
        image = "ghcr.io/karakeep-app/karakeep:0.34.1";

        dependsOn = ["meilisearch" "chrome"];

        ports = [
          "5000:3000"
        ];

        volumes = [
          "/srv/data/karakeep/data:/data"
        ];

        environment = {
          "MEILI_ADDR" = "http://meilisearch:7700";
          "BROWSER_WEB_URL" = "http://chrome:9222";
          "DATA_DIR" = "/data";
        };

        environmentFiles = [config.age.secrets.karakeep.path];

        extraOptions = [
          "--network=karakeep-net"
        ];
      };

      meilisearch = {
        image = "docker.io/getmeili/meilisearch:v1.41.0";
        environment = {
          "MEILI_NO_ANALYTICS" = "true";
        };
        environmentFiles = [config.age.secrets.karakeep.path];
        volumes = [
          "/srv/data/karakeep/meili:/meili_data"
        ];
        extraOptions = [
          "--network=karakeep-net"
        ];
      };

      chrome = {
        # the entrypoint already sets --no-sandbox and serves CDP on 9222
        image = "ghcr.io/karakeep-app/karakeep-chrome:157.0.8103.38-r1";
        cmd = [
          "--disable-gpu"
          "--disable-dev-shm-usage"
          "--hide-scrollbars"
          "--disable-blink-features=AutomationControlled"
          "--window-size=1440,900"
        ];
        extraOptions = [
          "--init"
          "--network=karakeep-net"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [5000];

    age.secrets = {
      karakeep = {
        file = "${inputs.secrets}/karakeep.age";
        mode = "600";
      };
    };
  };
}
