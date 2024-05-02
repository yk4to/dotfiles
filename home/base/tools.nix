{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat # `cat` replacement
    eza # `ls` replacement
    zoxide # `cd` replacement

    delta # git diff viewer
    hyperfine # benchmarking tool

    neofetch # system info
    
    nodejs_latest
  ];
}