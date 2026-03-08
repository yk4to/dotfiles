{
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.services;
in {
  imports = mylib.scanPaths ./.;

  options.optionalModules.nixos.services = {
    enable = mkEnableOption "Self-hosted services";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;

      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers.backend = "podman";
    };
  };
}
