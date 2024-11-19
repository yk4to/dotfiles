{
  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.sessionVariables = {
    DIRENV_WARN_TIMEOUT = "3m";
  };
}
