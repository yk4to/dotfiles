{vars, ...}: {
  programs = {
    git.enable = true;
    fish.enable = true;
  };

  # set time zone
  time.timeZone = vars.timeZone;

  # set locale
  i18n.defaultLocale = "ja_JP.UTF-8";

  # enable auto optimisation and gc
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # enable ssh
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
