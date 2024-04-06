{
  imports = [
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
    ./symlink.nix
    ./tools.nix
  ];

  programs.home-manager.enable = true;
}