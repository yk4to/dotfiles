{
  virtualisation.arion.projects.portainer.settings = {
    services.portainer = {
      service.image = "portainer/portainer-ce:latest";
      service.container_name = "portainer";
      service.volumes = [
        {
          type = "volume";
          source = "data";
          target = "/data";
        }
        {
          type = "volume";
          source = "/var/run/docker.sock";
          target = "/var/run/docker.sock";
        }
      ];
      service.ports = ["9443:9443"];
      service.restart = "unless-stopped";
    };

    docker-compose.volumes = {
      data = {};
    };
  };
}
