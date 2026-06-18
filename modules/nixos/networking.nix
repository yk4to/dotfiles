{vars, ...}: {
  # Enable NetworkManager
  networking.networkmanager.enable = true;
  users.users.${vars.username}.extraGroups = ["networkmanager"];

  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
  networking.firewall.allowedUDPPorts = [5353];
}
