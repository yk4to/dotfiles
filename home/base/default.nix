{ pkgs, vars, ... }: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./tools.nix

    ./fish
    ./ghostty
    ./nvim
  ];

  home = rec {
    username = vars.username;
    homeDirectory = if pkgs.stdenv.isDarwin then
      "/Users/${vars.username}"
    else
      "/home/${vars.username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}