{ pkgs, ... }: {
  home.packages = with pkgs; [
    eza # `ls` replacement
    zoxide # `cd` replacement

    delta # git diff viewer
    hyperfine # benchmarking tool

    neofetch # system info (deprecated)
    bottom # system monitor
    
    nodejs_latest
  ];

  # `cat` replacement
  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };
}