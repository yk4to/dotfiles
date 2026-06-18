{
  x13 = {
    system = "x86_64-linux";
    stateVersion = "25.05";
    displays = [
      {
        connector = "eDP-1";
        resolution = {
          width = 1920;
          height = 1080;
        };
        inch = 13.3;
        is_laptop = true;
      }
    ];
  };

  mate = {
    system = "x86_64-linux";
    stateVersion = "25.05";
  };

  lucy-wsl = {
    system = "x86_64-linux";
    stateVersion = "26.05";
  };

  yuta-mba = {
    system = "aarch64-darwin";
    darwinStateVersion = 5;
    stateVersion = "23.11";
  };
}
