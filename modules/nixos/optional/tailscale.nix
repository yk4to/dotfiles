{
  pkgs,
  config,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.tailscale];

  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;

    # always allow traffic from your Tailscale network
    trustedInterfaces = ["tailscale0"];

    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [config.services.tailscale.port];

    # let you SSH in over the public internet
    allowedTCPPorts = [22];
  };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = ["network-pre.target" "tailscale.service"];
    wants = ["network-pre.target" "tailscale.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 5

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up -authkey $(<${config.age.secrets.tailscale.path})
    '';
  };

  age.secrets = {
    tailscale = {
      file = "${inputs.secrets}/tailscale.age";
      owner = "tailscale";
      group = "tailscale";
    };
  };
}
