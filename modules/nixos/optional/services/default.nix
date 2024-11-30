{
  pkgs,
  inputs,
  vars,
  config,
  lib,
  mylib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.services;
in {
  imports =
    (mylib.scanPaths ./.)
    ++ [
      inputs.arion.nixosModules.arion
    ];

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
      };
      oci-containers.backend = "podman";

      # TODO: remove Arion and migrate to Podman
      docker.enable = true;
      arion.backend = "docker";
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

    age.secrets = {
      cloudflared = {
        file = "${inputs.secrets}/cloudflared.age";
        owner = "cloudflared";
        group = "cloudflared";
      };
    };
  };
}
