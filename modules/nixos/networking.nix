{vars, ...}: {
  # Enable NetworkManager
  networking.networkmanager.enable = true;
  users.users.${vars.username}.extraGroups = ["networkmanager"];

  # Enable ssh
  services.openssh.enable = true;
  # disable to prevent conflict with services.gnome.gcr-ssh-agent.enable
  # programs.ssh.startAgent = true;

  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
  networking.firewall.allowedUDPPorts = [5353];
}
