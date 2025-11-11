{pkgs, ...}: {
  home.packages = with pkgs; [
    eza # `ls` replacement
    ripgrep # `grep` replacement
    zoxide # `cd` replacement
    fzf # fuzzy finder

    just # simple task runner

    hyperfine # benchmarking tool

    bottom # system monitor

    nodejs_latest

    nix-output-monitor
    nixd # nix language server
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
