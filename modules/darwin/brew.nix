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
      "Goodnotes" = 1444383602;
      "Logic Pro" = 634148309;
      "ReadKit" = 1615798039;
      "TitechApp" = 1400068981;

      # Utilities
      "Amphetamine" = 937984704;
      "Hand Mirror" = 1502839586;
      "Pure Paste" = 1611378436;
      "Sleeve" = 1606145041;
      "Velja" = 1607635845;

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

    taps = [
      # "homebrew/cask-fonts"
    ];

    brews = [
    ];

    casks = [
      # Browsers
      "arc"
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
      "coteditor"
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
      "tailscale"
      "visual-studio-code"
      "xcodes"

      # Design Tools
      "adobe-creative-cloud"
      "figma"
      "sketch"

      # CAD
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
      "todoist"
    ];
  };
}
