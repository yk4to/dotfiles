{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "services.nextdns";

  options = delib.singleEnableOption true;

  nixos.always.age.secrets = {
    nextdns = {
      file = "${inputs.secrets}/nextdns.age";
      mode = "600";
    };
  };

  nixos.ifEnabled = {myconfig, ...}: let
    inherit (myconfig.services.nextdns) age;
  in {
    services.nextdns = {
      enable = true;
      arguments = ["-config-file" "${age.secrets.nextdns.path}"];
    };

    networking.nameservers = [
      "127.0.0.1"
      "::1"
    ];
  };
}
