{
  virtualisation.arion.projects.rss-bridge.settings = {
    services.rss-bridge = {
      service.image = "rssbridge/rss-bridge:latest";
      service.container_name = "rss-bridge";
      service.volumes = [
        {
          type = "volume";
          source = "config";
          target = "/config";
        }
      ];
      service.ports = ["3000:80"];
      service.restart = "unless-stopped";
    };

    docker-compose.volumes = {
      config = {};
    };
  };
}
