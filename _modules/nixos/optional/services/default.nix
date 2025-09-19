{
  inputs,
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

    services.cloudflared = {
      enable = true;

      tunnels = {
        "bed69fbf-bc28-4eea-9d9e-be8d6601dc76" = {
          credentialsFile = config.age.secrets.cloudflared.path;
          ingress = {
            "rss.fus1on.dev" = "http://localhost:80";
            "memos.fus1on.dev" = "http://localhost:5230";
          };
          default = "http_status:404";
        };
      };
    };

    age.secrets.cloudflared.file = "${inputs.secrets}/cloudflared.age";
  };
}
