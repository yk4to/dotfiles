{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.services;
in {
  options.optionalModules.nixos.services = {
    enable = mkEnableOption "Self-hosted services";
  };

  config = mkIf cfg.enable {
    optionalModules.nixos.docker.enable = true;

    virtualisation = {
      # Dokploy runs on Docker Swarm, which is incompatible with live-restore.
      docker.liveRestore = false;

      oci-containers.backend = "docker";
    };
  };
}
