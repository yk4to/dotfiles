{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "ime";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };
}
