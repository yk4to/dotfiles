{
  inputs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    virtualisation.arion.projects.portainer.settings = {
      services.portainer.service = {
        image = "portainer/portainer-ce:latest";
        container_name = "portainer";
        volumes = [
          {
            type = "volume";
            source = "data";
            target = "/data";
          }
          {
            type = "bind";
            source = "/var/run/docker.sock";
            target = "/var/run/docker.sock";
          }
        ];
        ports = ["9443:9443"];
        restart = "unless-stopped";
      };

      docker-compose.volumes = {
        data = {};
      };
    };
  };
}
