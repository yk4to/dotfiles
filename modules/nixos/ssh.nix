{
  ...
}: {
  services.openssh.enable = true;

  # Disable this to prevent conflict with services.gnome.gcr-ssh-agent.enable.
  # programs.ssh.startAgent = true;
}
