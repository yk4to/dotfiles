{
  inputs,
  vars,
  pkgs,
  ...
}: {
  imports = [
    ./freshrss.nix
  ];

  # Setup Arion
  imports = with inputs; [
    inputs.arion.nixosModules.arion
  ];

  virtualisation = {
    docker.enable = true;
    arion.backend = "docker";
  };
}
