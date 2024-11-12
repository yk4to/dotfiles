{pkgs, ...}: {
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
      "Logic Pro" = 634148309;
      "ReadKit" = 1615798039;
      "Todoist" = 585829637;
      "TitechApp" = 1400068981;

      # Utilities
      "Amphetamine" = 937984704;
      "Hand Mirror" = 1502839586;
      "Pure Paste" = 1611378436;
      "Sleeve" = 1606145041;
      "Velja" = 1607635845;

      # Dev Tools
      "Tailscale" = 1475387142;

      # Safari Extensions
      "1Password for Safari" = 1569813296;
      "1Blocker" = 1365531024;
      "Consent-O-Matic" = 1606897889;
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

    # Until Ghostty is added to the official casks registry,
    # install it from the unofficial tap
    taps = [
      "indirect/tap"
    ];

    brews = [
      "mecab"
      "mecab-ipadic"
    ];

    casks = [
      # Browsers
      "google-chrome"

      # Utilities
      "alt-tab"
      "appcleaner"
      "bartender"
      "cleanshot"
      "iina"
      "istat-menus"
      "jordanbaird-ice"
      "karabiner-elements"
      "keka"
      "keyboardcleantool"
      "latest"
      "logi-options+"
      "monitorcontrol"
      "notchnook"
      "raycast"
      "rectangle"
      "1password"

      # Editors
      "inkdrop"
      "obsidian"

      # Dev Tools
      "apparency"
      "arduino-ide"
      "balenaetcher"
      "clion"
      "orbstack"
      "raspberry-pi-imager"
      "sf-symbols"
      "visual-studio-code"
      "xcodes"
      "indirect/tap/ghostty"

      # Design Tools
      "adobe-creative-cloud"
      "figma"
      "sketch"

      # CAD
      "autodesk-fusion"
      "kicad"

      # 3D Printing
      "bambu-studio"

      # Cloud Storage
      # "box-drive"
      "google-drive"

      # Communication
      "discord"
      "slack"
      "zoom"

      # LLM
      "chatgpt"

      # Others
      "microsoft-auto-update"
      "microsoft-office"
    ];
  };

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_ENV_HINTS = "0";
  };
}
