{
  imports = [
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./tools.nix

    ./fish
    ./ghostty
    ./nvim
  ];

  programs.home-manager.enable = true;
}