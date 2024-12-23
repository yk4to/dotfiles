{pkgs, ...}: {
  home.packages = with pkgs; [
    cava # audio visualizer
    trashy

    sysz # a fzf terminal UI for systemctl
  ];
}
