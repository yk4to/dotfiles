{pkgs, ...}: {
  home.packages = with pkgs; [
    trashy

    sysz # a fzf terminal UI for systemctl
  ];

  programs.tmux.enable = true;

  # audio visualizer
  programs.cava.enable = true;
}
