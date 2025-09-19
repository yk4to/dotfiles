{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.platformio";

  options = delib.singleEnableOption host.electronicsFeatured;

  home.ifEnabled.home.packages = [pkgs.platformio];
}
