{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fish
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment = {
    shells = [pkgs.zsh pkgs.fish];
    loginShell = pkgs.fish;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
      # Apps
      "Logic Pro" = 634148309;
      "Sleeve" = 1606145041;
      "TitechApp" = 1400068981;

      # Safari Extensions
      "1Password for Safari" = 1569813296;
      "1Blocker" = 1365531024;
      "uBlacklist" = 1547912640;
      "Refined GitHub" = 1519867270;
      "Control Panel for Twitter" = 1668516167;
      "Control Panel for YouTube" = 6478456678;
      "Userscripts" = 1463298887;
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
      "karabiner-elements"
      "keka"
      "keyboardcleantool"
      "latest"
      "logi-options-plus"
      "monitorcontrol"
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
      "orbstack"
      "raspberry-pi-imager"
      "sf-symbols"
      "tailscale"
      "visual-studio-code"
      "xcodes"

      # Design Tools
      "adobe-creative-cloud"
      "figma"

      # Cloud Storage
      "box-drive"
      "google-drive"

      # Communication
      "discord"
      "slack"
      "zoom"

      # Others
      "microsoft-auto-update"
      "microsoft-office"
      "todoist"
    ];
  };
}
