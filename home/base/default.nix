{
  imports = [
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
    ./tools.nix

    ./ghostty
  ];

  programs.home-manager.enable = true;
}