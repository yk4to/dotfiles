{
  virtualisation.arion.projects.rss-bridge.settings = {
    services.rss-bridge.service = {
      image = "rssbridge/rss-bridge:latest";
      container_name = "rss-bridge";
      volumes = [
        {
          type = "volume";
          source = "config";
          target = "/config";
        }
      ];
      ports = ["3000:80"];
      restart = "unless-stopped";
    };

    docker-compose.volumes = {
      config = {};
    };
  };
}
