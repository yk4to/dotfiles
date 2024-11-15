{
  inputs,
  vars,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./freshrss.nix
    ./memos.nix
    ./portainer.nix

    inputs.arion.nixosModules.arion
  ];

  virtualisation = {
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
}
