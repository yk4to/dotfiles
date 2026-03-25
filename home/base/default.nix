{
  mylib,
  vars,
  isDarwin,
  hostConfig,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home = {
    stateVersion = hostConfig.stateVersion;
    username = vars.username;
    homeDirectory =
      if isDarwin
      then "/Users/${vars.username}"
      else "/home/${vars.username}";
  };

  programs.home-manager.enable = true;
}
