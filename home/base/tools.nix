{pkgs, ...}: {
  home.packages = with pkgs; [
    eza # `ls` replacement
    zoxide # `cd` replacement

    just # `make` replacement

    hyperfine # benchmarking tool

    neofetch # system info (deprecated)
    bottom # system monitor

    nodejs_latest

    nix-output-monitor
    alejandra # nix formatter
  ];

  # `cat` replacement
  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };

  # system info (`neofetch` replacement)
  programs.fastfetch = {
    enable = true;

    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        # "theme"
        # "font"
        # "cursor"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        # "swap"
        "disk"
        # "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
        "break"
      ];
    };
  };
}
