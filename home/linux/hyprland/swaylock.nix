{ pkgs, ... }: {
  home.packages = [ pkgs.swaylock-effects ];
  home.file.".config/swaylock/config".text = ''
    effect-blur=5x5
  '';
}