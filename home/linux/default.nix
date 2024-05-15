{
  imports = [
    ./apps.nix
    ./gnome.nix
    ./hyprland.nix
    ./ssh.nix

    ../base
  ];

  home = rec {
    username = "yuta";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
}