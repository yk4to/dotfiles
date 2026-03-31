{pkgs, ...}: {
  home.packages = with pkgs; [
    trashy

    sysz # a fzf terminal UI for systemctl
  ];

  # audio visualizer
  programs.cava.enable = true;
}
