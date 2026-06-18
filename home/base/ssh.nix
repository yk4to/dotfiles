{
  lib,
  isDarwin,
  hostName,
  machines,
  vars,
  ...
}: let
  machineNames = builtins.filter (name: name != hostName) (builtins.attrNames machines);
  machineSshSettings = lib.genAttrs machineNames (name: {
    # Use the machine name as the MagicDNS hostname on Tailscale.
    HostName = name;
    User = vars.username;
  });
in {
  programs.ssh = {
    enable = true;

    # Keep Home Manager from reintroducing the legacy default Host * block.
    # This option will become deprecated in the future.
    enableDefaultConfig = false;

    # Include Orbstack config on macOS
    includes = lib.optional isDarwin "~/.orbstack/ssh/config";

    settings = machineSshSettings;
  };
}
