{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.gui.enable {
    catppuccin.cursors = {
      enable = true;
      accent = "mauve";
    };
  };
}
