{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.hyprland.enable {
    services.swaync.enable = true;
  };
}
