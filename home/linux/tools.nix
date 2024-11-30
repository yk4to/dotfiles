{pkgs, ...}: {
  home.packages = with pkgs; [
    # cava # audio visualizer
    trashy
  ];
}
