{
  pkgs,
  hostConfig,
  vars,
  ...
}: {
  programs = {
    git.enable = true;
    zsh.enable = true;
  };

  system.stateVersion = hostConfig.stateVersion;

  time.timeZone = vars.timeZone;

  i18n.defaultLocale = vars.locale;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # terminfo for Ghostty (not included in ncurses)
  # NOTE: `environment.enableAllTerminfo` builds rxvt-unicode from source, which fails with GCC 16
  # ref: https://github.com/NixOS/nixpkgs/pull/568978
  environment.systemPackages = [pkgs.ghostty.terminfo];
}
