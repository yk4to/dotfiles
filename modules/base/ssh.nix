{
  inputs,
  vars,
  otherMachineNames,
  ...
}: let
  publicKeys = import (inputs.secrets + "/public-keys.nix");
  managedMachinePublicKeys =
    map (
      name:
        publicKeys.${name} or (throw "Missing SSH public key for machine ${name}")
    )
    otherMachineNames;
in {
  # Allow passwordless SSH between managed machines using the public keys
  # tracked in the secrets repository.
  users.users.${vars.username}.openssh.authorizedKeys.keys = managedMachinePublicKeys;
}
