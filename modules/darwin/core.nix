{
  hostConfig,
  vars,
  pkgs,
  ...
}: {
  system.stateVersion = hostConfig.darwinStateVersion;

  nix.package = pkgs.nix;

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
