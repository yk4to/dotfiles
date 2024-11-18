{
  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };

  environment.variables = {
    DIRENV_WARN_TIMEOUT = "3m";
  };
}
