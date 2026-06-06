{pkgs, ...}: {
  home.packages = with pkgs; [
    macism
    darwin.trash
    tart
  ];
}
