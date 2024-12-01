{
  vars,
  inputs,
  system,
  ...
}: {
  # Install agenix
  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/${vars.username}/.ssh/id_ed25519"
  ];
}
