{
  inputs,
  lib,
  isDarwin,
  hostName,
  machines,
  vars,
  ...
}: let
  machineNames = builtins.filter (name: name != hostName) (builtins.attrNames machines);
  publicKeys = import (inputs.secrets + "/public-keys.nix");
  machineSshSettings = lib.genAttrs machineNames (name: {
    # Use the machine name as the MagicDNS hostname on Tailscale.
    HostName = name;
    User = vars.username;
  });
  managedMachinePublicKeys = map (name:
    publicKeys.${name} or (throw "Missing SSH public key for machine ${name}")
  ) (builtins.attrNames machines);
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

  # Allow passwordless SSH between managed machines using the public keys
  # tracked in the secrets repository.
  home.file.".ssh/authorized_keys".text =
    lib.concatStringsSep "\n" managedMachinePublicKeys + "\n";
}
