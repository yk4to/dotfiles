{
  mylib,
  vars,
  isDarwin,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home = {
    username = vars.username;
    homeDirectory =
      if isDarwin
      then "/Users/${vars.username}"
      else "/home/${vars.username}";
  };

  programs.home-manager.enable = true;
}
