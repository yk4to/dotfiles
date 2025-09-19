{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "user";

  # Don't forget to set a password with ‘passwd’ on NixOS.

  nixos.always = {myconfig, ...}: let
    inherit (myconfig.constants) username userfullname;
  in {
    users = {
      groups.${username} = {};

      users.${username} = {
        description = userfullname;
        shell = pkgs.fish;

        isNormalUser = true;
        initialPassword = username;
        extraGroups = ["wheel"];
      };
    };
  };

  darwin.always = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    users.users.${username} = {
      name = username;
      home = "/Users/${username}";
    };
  };
}
