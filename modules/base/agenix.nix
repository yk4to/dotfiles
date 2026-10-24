{
  vars,
  inputs,
  isDarwin,
  system,
  ...
}: {
  imports = [
    (
      if isDarwin
      then inputs.agenix.darwinModules.default
      else inputs.agenix.nixosModules.default
    )
  ];

  # Install agenix
  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    (
      if isDarwin
      then "/Users/${vars.username}/.ssh/id_ed25519"
      else "/home/${vars.username}/.ssh/id_ed25519"
    )
  ];
}
