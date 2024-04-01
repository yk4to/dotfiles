{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    eza
    hyperfine
    lazygit
    neofetch
    zoxide

    nodejs_21
  ];
}