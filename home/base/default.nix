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
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
