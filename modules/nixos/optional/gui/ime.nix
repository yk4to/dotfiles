{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    # TODO: uncomment this when #355852 is solved
    # fcitx5.addons = [pkgs.fcitx5-mozc];
  };
}
