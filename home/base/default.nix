{
  imports = [
    ./fish.nix
    ./git.nix
    ./symlink.nix
    ./tools.nix
  ];

  programs.home-manager.enable = true;
}