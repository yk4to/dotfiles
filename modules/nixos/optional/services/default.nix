{
  inputs,
  vars,
  pkgs,
  ...
}: {
  imports = [
    ./freshrss.nix

    inputs.arion.nixosModules.arion
  ];

  virtualisation = {
    docker.enable = true;
    arion.backend = "docker";
  };
}
