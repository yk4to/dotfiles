{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.direnv";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;

      config.global = {
        hide_env_diff = true;
      };
    };

    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = "3m";
      # make direnv log less noisy
      DIRENV_LOG_FORMAT = ''$(printf "\033[2mdirenv: %%s\033[0m")'';
    };
  };
}
