{
  delib,
  host,
  ...
}:
delib.module {
  name = "darwin.karabiner";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.xdg.configFile."karabiner/karabiner.json".source = ./karabiner.json;
}
