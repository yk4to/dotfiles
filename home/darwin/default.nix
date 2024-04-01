{
  imports = [
    ./shell.nix

    ../base
  ];

  home = rec {
    username = "yuta";
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };
}