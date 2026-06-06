{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.gui.enable {
    # Keep the system input method aligned with the Home Manager fcitx5 setup so
    # GNOME's ibus default does not leak GTK_IM_MODULE=ibus into the session.
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
    };
  };
}
