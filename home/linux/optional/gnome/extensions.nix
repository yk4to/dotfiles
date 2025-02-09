{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.gnome.enable (let
    extensions = with pkgs.gnomeExtensions; [
      pop-shell # tiling window manager
      dash-to-dock # dock used in Ubuntu
      kimpanel # show ime status on menu bar
      appindicator # show indicator icons on menu bar
      caffeine # prevent screen from turning off
    ];
  in {
    home.packages = extensions;

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = map (p: p.extensionUuid or p.uuid) extensions;

      "org/gnome/shell/extensions/pop-shell" = {
        tile-by-default = true;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "LEFT";
        autohide = false;
        autohide-in-fullscreen = false;
        extend-height = true;
        intellihide = false;

        apply-custom-theme = true;
        custom-theme-shrink = true;
      };
    };
  });
}
