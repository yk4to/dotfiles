{
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
    ./tools.nix

    ./fish
    ./ghostty
  ];

  programs.home-manager.enable = true;
}