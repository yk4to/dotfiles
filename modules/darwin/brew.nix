{
  inputs,
  config,
  vars,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = vars.username;

    # Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    # Apps from App Store
    masApps = {
      # Apps
      "CotEditor" = 1024640650;
      "Goodnotes" = 1444383602;
      "LINE" = 539883307;
      # "Logic Pro" = 634148309;
      # "ReadKit" = 1615798039;
      "Todoist" = 585829637;

      # Office
      "Microsoft Word" = 462054704;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;

      # Utilities
      "Amphetamine" = 937984704;
      "CleanMyKeyboard" = 6468120888;
      "Hand Mirror" = 1502839586;
      "Pure Paste" = 1611378436;
      "Sleeve" = 1606145041;
      "Speedtest" = 1153157709;
      # "Velja" = 1607635845;

      # Dev Tools
      "Tailscale" = 1475387142;

      # Safari Extensions
      "1Blocker" = 1365531024;
      "uBlacklist" = 1547912640;
      "Refined GitHub" = 1519867270;
      "File Icons for GitHub and GitLab" = 1631366167;
      "Keepa" = 1533805339;
      "Control Panel for Twitter" = 1668516167;
      "Control Panel for YouTube" = 6478456678;
      "Userscripts" = 1463298887;
      "Wappalyzer" = 1520333300;
      "T2Extension" = 1603240737;
    };

    # pass all taps to avoid untapping all taps
    # ref: https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "mas"
    ];

    casks = [
      # Browsers
      "arc"
      "chatgpt-atlas"
      "thebrowsercompany-dia"
      "google-chrome"

      # Utilities
      "appcleaner"
      # "bartender"
      "betterdisplay"
      "cleanshot"
      "iina"
      "istat-menus"
      "jordanbaird-ice@beta"
      "karabiner-elements"
      "keka"
      "latest"
      "logi-options+"
      "mac-mouse-fix"
      # "monitorcontrol"
      # "notchnook"
      "raycast"
      "rectangle"

      # Notes
      "inkdrop"
      "notion"

      # Dev Tools
      "apparency"
      "arduino-ide"
      "balenaetcher"
      "clion"
      "orbstack"
      "raspberry-pi-imager"
      # "sf-symbols"
      "visual-studio-code"
      # "xcodes"
      "ghostty"

      # Design Tools
      "adobe-creative-cloud"
      "figma"
      "sketch"
      "icon-composer"

      # CAD
      "autodesk-fusion"
      "kicad"

      # 3D Printing
      "creality-print"
      "bambu-studio"

      # Cloud Storage
      # "box-drive"
      # "google-drive"

      # Communication
      "discord"
      "microsoft-teams"
      "slack"
      "zoom"

      # AI
      "chatgpt"

      # Others
      "anki"
    ];
  };

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
  };
}
