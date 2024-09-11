{
  # use TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # keep ghostty terminfo
  # ref: https://ryanccn.dev/posts/ghostty-sudo-terminfo/
  # `security.sudo.keepTerminfo` does not exist in nix-darwin
  security.sudo.extraConfig = ''
    Defaults    env_keep += "TERMINFO"
  '';

  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      # show 24 hour clock
      menuExtraClock.Show24Hour = true;

      dock = {
        autohide = false;
        show-recents = false; # do not show recent apps in dock
        # mru-spaces = false;

        # disable hot corners
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };

      finder = {
        # show file extensions
        AppleShowAllExtensions = true;
        # show path bar
        ShowPathbar = true;
      };

      NSGlobalDomain = {
        # disable natural scrolling
        "com.apple.swipescrolldirection" = false;
      };

      # customize settings not directly supported by nix-darwin
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.WindowManager" = {
          # disable "Click wallpaper to reveal desktop"
          EnableStandardClickToShowDesktop = 0;
        };
        # prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
      };
    };
  };
}
