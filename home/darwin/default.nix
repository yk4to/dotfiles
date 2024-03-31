{
  imports = [
    ../base
  ];

  home = rec {
    username = "yuta";
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # to set Nix-related paths to zsh
  programs.zsh.enable = true;
}