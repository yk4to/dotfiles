{delib, ...}:
delib.module {
  name = "services.mdns";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };
    networking.firewall.allowedUDPPorts = [5353];
  };
}
