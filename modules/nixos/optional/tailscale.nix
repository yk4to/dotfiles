{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.tailscale;
in {
  options.optionalModules.nixos.tailscale = {
    enable = mkEnableOption "Tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale.path;
      openFirewall = true;
    };

    networking = {
      nftables.enable = true;

      firewall = {
        enable = true;

        # always allow traffic from your Tailscale network
        trustedInterfaces = ["tailscale0"];

        # let you SSH in over the public internet
        allowedTCPPorts = [22];
      };
    };

    # Force tailscaled to use nftables
    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    # Prevent systemd from waiting for network online
    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;

    age.secrets = {
      tailscale = {
        file = "${inputs.secrets}/tailscale.age";
        mode = "600";
      };
    };
  };
}
