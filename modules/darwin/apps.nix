{ pkgs, ... }: {
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
      cleanup = "zap";
    };

    masApps = {
      # Xcode = 497799835;
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
      "raycast"
      "rectangle"

      # Editors
      "coteditor"
      "inkdrop"
      "obsidian"

      # Dev Tools
      "apparency"
      "arduino-ide"
      # "balenaetcher"
      "orbstack"
      "sf-symbols"
      "visual-studio-code"
      "xcodes"

      # Design Tools
      # "adobe-creative-cloud"
      "figma"

      # Others
      "discord"
      # "google-drive"
      "slack"
      "zoom"
    ];
  };
}