{vars, ...}: {
  programs = {
    git.enable = true;
    fish.enable = true;
  };

  time.timeZone = vars.timeZone;

  i18n.defaultLocale = vars.locale;

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

  # enable all terminfo entries to support Ghostty and other terminal apps
  environment.enableAllTerminfo = true;
}
