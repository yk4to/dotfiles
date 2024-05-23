{
  imports = [
    ./apps.nix
    ./gnome.nix
    ./services.nix
    ./tools.nix

    ./hyprland

    ../base
  ];

  home = rec {
    username = "yuta";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
}