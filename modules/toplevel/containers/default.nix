{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "containers";

  options = delib.singleEnableOption false;

  nixos.always.age.secrets.cloudflared.file = "${inputs.secrets}/cloudflared.age";

  nixos.ifEnabled = {myconfig, ...}: let
    inherit (myconfig.services.containers) age;
  in {
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
          credentialsFile = age.secrets.cloudflared.path;
          ingress = {
            "rss.fus1on.dev" = "http://localhost:80";
            "memos.fus1on.dev" = "http://localhost:5230";
          };
          default = "http_status:404";
        };
      };
    };
  };
}
