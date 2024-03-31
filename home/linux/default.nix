{
  imports = [
    ./apps.nix
    ./gnome.nix

    ../base
  ];

  home = rec {
    username = "yk4to";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
}