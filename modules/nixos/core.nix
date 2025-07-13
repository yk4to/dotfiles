{vars, ...}: {
  programs = {
    git.enable = true;
    fish.enable = true;
  };

  # set time zone
  time.timeZone = vars.timeZone;

  # set locale
  i18n.defaultLocale = "en_US.UTF-8";

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
}
