{hostConfig, ...}: {
  home.stateVersion = hostConfig.stateVersion;

  programs.home-manager.enable = true;
}
