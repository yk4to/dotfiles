{
  pkgs,
  mylib,
  vars,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home = {
    username = vars.username;
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${vars.username}"
      else "/home/${vars.username}";
  };

  programs.home-manager.enable = true;
}
