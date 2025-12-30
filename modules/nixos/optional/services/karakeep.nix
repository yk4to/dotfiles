{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/karakeep/data 0755 root root - -"
      "d /var/lib/karakeep/meili 0755 root root - -"
    ];

    systemd.services."create-podman-karakeep-network" = {
      path = [pkgs.podman];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.podman}/bin/podman network rm -f karakeep-net";
      };
      script = ''
        ${pkgs.podman}/bin/podman network exists karakeep-net \
          || ${pkgs.podman}/bin/podman network create karakeep-net
      '';
      wantedBy = ["multi-user.target"];
    };

    virtualisation.oci-containers.containers = {
      karakeep = {
        image = "ghcr.io/karakeep-app/karakeep:0.29.3";

        dependsOn = ["meilisearch" "chrome"];

        ports = [
          "5000:3000"
        ];

        volumes = [
          "/var/lib/karakeep/data:/data"
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
        image = "getmeili/meilisearch:v1.13.3";
        environment = {
          "MEILI_NO_ANALYTICS" = "true";
        };
        environmentFiles = [config.age.secrets.karakeep.path];
        volumes = [
          "/var/lib/karakeep/meili:/meili_data"
        ];
        extraOptions = [
          "--network=karakeep-net"
        ];
      };

      chrome = {
        image = "gcr.io/zenika-hub/alpine-chrome:124";
        cmd = [
          "--no-sandbox"
          "--disable-gpu"
          "--disable-dev-shm-usage"
          "--remote-debugging-address=0.0.0.0"
          "--remote-debugging-port=9222"
          "--hide-scrollbars"
        ];
        extraOptions = [
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
