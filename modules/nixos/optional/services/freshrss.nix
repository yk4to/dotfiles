{
  virtualisation.arion.projects.freshrss.settings = {
    services.freshrss.service = {
      image = "lscr.io/linuxserver/freshrss:version-1.24.1";
      container_name = "freshrss";
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Asia/Tokyo";
        CRON_MIN = "1,16,31,46";
      };
      volumes = [
        {
          type = "volume";
          source = "config";
          target = "/config";
        }
      ];
      extra_hosts = [
        "host.docker.internal:host-gateway"
      ];
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
      ports = ["3000:80"];
      restart = "unless-stopped";
    };

    docker-compose.volumes = {
      config = {};
    };
  };
}
