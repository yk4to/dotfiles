{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.apps";

  options = delib.singleEnableOption (host.guiFeatured && pkgs.stdenv.isLinux);

  home.ifEnabled.home.packages = with pkgs; [
    discord
    slack

    todoist-electron
  ];
}
