{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fish
  ];

  programs.zsh.enable = true;
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

    ];
  };
}