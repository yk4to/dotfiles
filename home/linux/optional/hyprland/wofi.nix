{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.hyprland.enable {
    programs.wofi = {
      enable = true;

      settings = {
        width = 500;
      };
    };
  };
}
