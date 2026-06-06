{
  vars,
  pkgs,
  ...
}: {
  # use TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # keep ghostty terminfo
  # ref: https://ryanccn.dev/posts/ghostty-sudo-terminfo/
  # `security.sudo.keepTerminfo` does not exist in nix-darwin
  security.sudo.extraConfig = ''
    Defaults    env_keep += "TERMINFO"
  '';

  system = {
    primaryUser = vars.username;

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

        persistent-apps = [
          "/System/Applications/Apps.app"
          "/Applications/Arc.app"
          "/System/Cryptexes/App/System/Applications/Safari.app"
          "/Applications/Google Chrome.app"
          "/System/Applications/Notes.app"
          "/System/Applications/Music.app"
          "/System/Applications/System Settings.app"
          "/Applications/Todoist.app"
          "/Applications/Discord.app"
          "/Applications/Slack.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "/Applications/Ghostty.app"
          "/Applications/CotEditor.app"
          "/Applications/Notion.app"
        ];

        persistent-others = [
          {
            folder = {
              path = "/Users/${vars.username}/Downloads";
              arrangement = "date-added";
              displayas = "stack";
              showas = "fan";
            };
          }
        ];

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
}
