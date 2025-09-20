{delib, ...}:
delib.module {
  name = "gc";

  nixos.always.nix = {
    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  darwin.always.nix = {
    # ref: https://github.com/NixOS/nix/issues/7273
    settings.auto-optimise-store = false;

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };
}
