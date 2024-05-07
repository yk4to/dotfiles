{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fish
    darwin.trash
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
      "Logic Pro" = 634148309;
      "Sleeve" = 1606145041;
      "TitechApp 3" = 1400068981;
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