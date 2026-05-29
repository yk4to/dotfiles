{
  hostConfig,
  vars,
  ...
}: {
  programs = {
    git.enable = true;
    fish.enable = true;
  };

  system.stateVersion = hostConfig.stateVersion;

  time.timeZone = vars.timeZone;

  i18n.defaultLocale = vars.locale;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # enable all terminfo entries to support Ghostty and other terminal apps
  environment.enableAllTerminfo = true;
}
