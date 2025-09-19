{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "home";

  home.always = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    home = {
      inherit username;

      homeDirectory =
        if pkgs.stdenv.isDarwin
        then "/Users/${username}"
        else "/home/${username}";
    };

    # programs.home-manager.enable = true;
  };
}
