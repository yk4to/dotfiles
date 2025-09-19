{delib, ...}:
delib.module {
  name = "services.networkmanager";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {myconfig, ...}: {
    networking.networkmanager.enable = true;
    users.users.${myconfig.constants.username}.extraGroups = ["networkmanager"];
  };
}
