{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.hyprland.enable {
    programs.swaylock = {
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        effect-blur = "5x5";
        ignore-empty-password = true;
      };
    };
  };
}
