{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.agenix";

  options = delib.singleEnableOption true;

  # TODO: refactor: avoid duplication between nixos and darwin

  nixos.always.imports = [inputs.agenix.nixosModules.default];

  nixos.ifEnabled = {myconfig, ...}: {
    environment.systemPackages = [
      inputs.agenix.packages."${host.system}".default
    ];

    age.identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/${myconfig.constants.username}/.ssh/id_ed25519"
    ];
  };

  darwin.always.imports = [inputs.agenix.darwinModules.default];

  darwin.ifEnabled = {myconfig, ...}: {
    environment.systemPackages = [
      inputs.agenix.packages."${host.system}".default
    ];

    age.identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/${myconfig.constants.username}/.ssh/id_ed25519"
    ];
  };
}
