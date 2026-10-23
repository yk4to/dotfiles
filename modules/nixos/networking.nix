{
  lib,
  config,
  vars,
  ...
}: let
  isWsl = config.wsl.enable or false;
in {
  config = lib.mkMerge [
    (lib.mkIf (!isWsl) {
      # NetworkManager is not used on WSL.
      networking.networkmanager.enable = true;
      users.users.${vars.username}.extraGroups = ["networkmanager"];
    })
    {
      # Enable mDNS
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        settings.publish = {
          disable-publishing = false;
          publish-addresses = true;
        };
      };
      networking.firewall.allowedUDPPorts = [5353];
    }
  ];
}
