{pkgs, ...}: {
  imports = [
    ./git.nix
    ./apps.nix
  ];

  home = rec {
    username = "yk4to";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  home.packages = with pkgs; [
    bat
    eza
    neofetch
    vscode
  ];
  
  programs.home-manager.enable = true;
}
