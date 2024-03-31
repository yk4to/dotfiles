{
  imports = [
    ./fish.nix
    ./git.nix
    ./tools.nix
  ]

  home = rec {
    username = "yk4to";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}