{
  inputs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    age.secrets.homepage.file = "${inputs.secrets}/homepage.age";

    environment.etc."homepage/docker.yaml".source = ./docker.yaml;
    environment.etc."homepage/widgets.yaml".source = ./widgets.yaml;
    environment.etc."homepage/services.yaml".source = ./services.yaml;

    virtualisation.oci-containers.containers.homepage = {
      image = "ghcr.io/gethomepage/homepage:v1.8.0";
      ports = ["10000:3000"];

      volumes = [
        "/etc/homepage:/app/config:ro"
        "/run/user/1000/podman/podman.sock:/var/run/podman.sock"
      ];

      environment = {
        HOMEPAGE_ALLOWED_HOSTS = "mate.local:10000";
        LOG_TARGETS = "stdout";
      };

      environmentFiles = [config.age.secrets.homepage.path];
    };

    networking.firewall.allowedTCPPorts = [10000];
  };
}
