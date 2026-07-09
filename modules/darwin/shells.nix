{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh];
  };

  programs = {
    zsh.enable = true;
  };
}
