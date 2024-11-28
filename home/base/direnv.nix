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
    DIRENV_LOG_FORMAT = ''\033[2mdirenv: %s\033[0m''; # make direnv log less noisy
  };
}
