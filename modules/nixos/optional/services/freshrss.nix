{
  inputs,
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    virtualisation.arion.projects.freshrss.settings = {
      services.freshrss.service = {
        image = "lscr.io/linuxserver/freshrss:version-1.24.1";
        container_name = "freshrss";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = vars.timeZone;
          CRON_MIN = "1,16,31,46";
        };
        volumes = [
          {
            type = "volume";
            source = "config";
            target = "/config";
          }
        ];
        networks = ["rss-net"];
        ports = ["80:80"];
        restart = "unless-stopped";
      };

      services.rss-bridge.service = {
        image = "rssbridge/rss-bridge:latest";
        container_name = "rss-bridge";
        /*
        volumes = [
          {
            type = "volume";
            source = "config";
            target = "/config";
          }
        ];
        */
        networks = ["rss-net"];
        ports = ["3000:80"];
        restart = "unless-stopped";
      };

      networks.rss-net.external = true;

      docker-compose.volumes = {
        config = {};
      };
    };

    age.secrets = {
      freshrss = {
        file = "${inputs.secrets}/freshrss.age";
        mode = "600";
      };
    };
  };
}
