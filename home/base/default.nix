{
  imports = [
    ./fish.nix
    ./git.nix
    ./starship.nix
    ./symlink.nix
    ./tools.nix
  ];

  programs.home-manager.enable = true;
}