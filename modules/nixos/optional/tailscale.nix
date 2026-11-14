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

      # always allow traffic from your Tailscale network
      firewall.trustedInterfaces = ["tailscale0"];
    };

    # Force tailscaled to use nftables
    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    age.secrets.tailscale.file = "${inputs.secrets}/tailscale.age";
  };
}
