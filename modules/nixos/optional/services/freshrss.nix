{config, ...}: {
  virtualisation.arion.projects.freshrss.settings = {
    services.freshrss = {
      service.image = "lscr.io/linuxserver/freshrss:version-1.24.1";
      service.container_name = "freshrss";
      service.environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Asia/Tokyo";
        CRON_MIN = "1,16,31,46";
      };
      service.volumes = [
        {
          type = "volume";
          source = "freshrss/config";
          target = "/config";
        }
        {
          type = "volume";
          source = "freshrss/data";
          target = "/var/www/FreshRSS/data";
        }
        {
          type = "volume";
          source = "freshrss/extensions";
          target = "/var/www/FreshRSS/extensions";
        }
      ];
      service.ports = ["80:80"];
      service.restart = "unless-stopped";
    };
  };
}
