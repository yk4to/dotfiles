{
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    virtualisation.oci-containers.containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss:version-1.24.3";
        volumes = [
          "config:/config"
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
          "--restart=unless-stopped"
        ];
      };

      rss-bridge = {
        image = "rssbridge/rss-bridge:latest";
        volumes = [
          "config:/config"
        ];
        ports = ["3000:80"];
        extraOptions = [
          "--network=rss-net"
          "--restart=unless-stopped"
        ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        80 # FreshRSS
        3000 # RSS-Bridge
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
