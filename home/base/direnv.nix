{
  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;

      config.global = {
        hide_env_diff = true;
      };
    };
  };

  home.sessionVariables = {
    DIRENV_WARN_TIMEOUT = "3m";
  };
}
