{
  inputs,
  vars,
  pkgs,
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
}
