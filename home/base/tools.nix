{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}: {
  home.packages = with pkgs; [
    eza # `ls` replacement
    ripgrep # `grep` replacement
    zoxide # `cd` replacement
    fzf # fuzzy finder

    hyperfine # benchmarking tool

    bottom # system monitor

    nodejs_latest
    bun
    biome

    nix-output-monitor
    nixd # nix language server
    alejandra # nix formatter
    comma # nix-shell wrapper
  ];

  # `cat` replacement
  programs.bat.enable = true;

  # shell history replacement
  programs.atuin = {
    enable = true;
    enableZshIntegration = false;
  };

  # fuzzy finder TUI
  programs.television = {
    enable = true;
    # `tv init zsh` binds Ctrl-R, which conflicts with Atuin
    enableZshIntegration = false;
  };

  # fuzzy search for Nix packages and options (`tv nix-search-tv`)
  programs.nix-search-tv = {
    enable = true;
    settings.indexes = ["nixpkgs" "home-manager" "nixos" "darwin" "nur"];
  };

  # nix-search-tv reads `~/Library/Application Support` on macOS unless `XDG_CONFIG_HOME` is set
  home.file."Library/Application Support/nix-search-tv/config.json" = lib.mkIf isDarwin {
    inherit (config.xdg.configFile."nix-search-tv/config.json") source;
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
