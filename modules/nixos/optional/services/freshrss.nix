{
  pkgs,
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/freshrss/config 0755 root root - -"
      "d /var/lib/rss-bridge/config 0755 root root - -"
    ];

    virtualisation.oci-containers.containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss:version-1.25.0";
        volumes = [
          "/var/lib/freshrss/config:/config"
        ];
        environment = {
          "TZ" = vars.timeZone;
          "PUID" = "1000";
          "PGID" = "1000";
          "CRON_MIN" = "1,16,31,46";
        };
        ports = ["80:80"];
        extraOptions = [
          "--network=rss-net"
        ];
      };

      rss-bridge = {
        image = "rssbridge/rss-bridge:latest";
        volumes = [
          "/var/lib/rss-bridge/config:/config"
        ];
        ports = ["3000:80"];
        extraOptions = [
          "--network=rss-net"
        ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        80 # FreshRSS
        3000 # RSS-Bridge
      ];

      # enable dns on `rss-net` network
      # ref: https://github.com/NixOS/nixpkgs/issues/226365#issuecomment-2164985192
      interfaces.podman1.allowedUDPPorts = [53];
    };

    systemd.services."create-podman-rss-network" = {
      path = [pkgs.podman];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.podman}/bin/podman network rm -f rss-net";
      };
      script = ''
        ${pkgs.podman}/bin/podman network exists rss-net || ${pkgs.podman}/bin/podman network create rss-net
      '';
      wantedBy = [
        "podman-freshrss.target"
        "podman-rss-bridge.target"
      ];
    };

    # age.secrets = {
    #   freshrss = {
    #     file = "${inputs.secrets}/freshrss.age";
    #     mode = "600";
    #   };
    # };
  };
}
