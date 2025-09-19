{delib, ...}:
delib.module {
  name = "darwin.system";

  darwin.always = {myconfig, ...}: {
    # use TouchID for sudo authentication
    security.pam.services.sudo_local.touchIdAuth = true;

    # keep ghostty terminfo
    # ref: https://ryanccn.dev/posts/ghostty-sudo-terminfo/
    # `security.sudo.keepTerminfo` does not exist in nix-darwin
    security.sudo.extraConfig = ''
      Defaults    env_keep += "TERMINFO"
    '';

    system = {
      primaryUser = myconfig.constants.username;

      defaults = {
        # show 24 hour clock
        menuExtraClock.Show24Hour = true;

        controlcenter = {
          AirDrop = false;
          BatteryShowPercentage = true;
          Bluetooth = true;
        };

        dock = {
          autohide = false;
          show-recents = false; # do not show recent apps in dock
          # mru-spaces = false;

          tilesize = 56;

          # disable hot corners
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
        };

        finder = {
          # show file extensions
          AppleShowAllExtensions = true;
          # set Finder's default view style to list view
          FXPreferredViewStyle = "Nlsv";
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
          # disable resizing Dock
          "com.apple.dock".size-immutable = true;

          "com.apple.desktopservices" = {
            # avoid creating .DS_Store files on network or USB volumes
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
  };
}
