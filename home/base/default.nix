{
  imports = [
    ./git.nix
    ./nvim.nix
    ./ssh.nix
    ./starship.nix
    ./tools.nix

    ./fish
    ./ghostty
  ];

  programs.home-manager.enable = true;
}