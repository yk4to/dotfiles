{
  inputs,
  vars,
  pkgs,
  ...
}: {
  imports = [
    ./freshrss.nix
    ./memos.nix

    inputs.arion.nixosModules.arion
  ];

  virtualisation = {
    docker.enable = true;
    arion.backend = "docker";
  };
}
