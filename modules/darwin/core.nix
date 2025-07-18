{
  vars,
  pkgs,
  ...
}: {
  nix.package = pkgs.nix;

  # ref: https://github.com/NixOS/nix/issues/7273
  nix.settings.auto-optimise-store = false;

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
