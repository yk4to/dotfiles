{
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