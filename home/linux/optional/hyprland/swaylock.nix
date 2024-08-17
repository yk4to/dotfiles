{pkgs, ...}: {
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      effect-blur = "5x5";
      ignore-empty-password = true;
    };
  };
}
