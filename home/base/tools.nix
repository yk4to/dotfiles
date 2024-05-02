{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    delta
    eza
    hyperfine
    neofetch
    zoxide

    nodejs_latest
  ];
}