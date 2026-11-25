{config, ...}: {
  security.sudo-rs = {
    enable = true;
    # follow NixOS-WSL, which disables the password requirement via security.sudo
    wheelNeedsPassword = config.security.sudo.wheelNeedsPassword;
  };
}
