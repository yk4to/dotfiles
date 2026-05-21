{
  hostConfig,
  vars,
  pkgs,
  ...
}: {
  system.stateVersion = hostConfig.darwinStateVersion;

  nix.package = pkgs.nix;

  # Optimise the store automatically during every build
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  environment.variables.LANG = vars.locale;
}
