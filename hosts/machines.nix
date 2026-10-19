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

  lucy = {
    system = "x86_64-linux";
    stateVersion = "26.05";
    displays = [
      {
        # TODO: Verify with `niri msg outputs` after the first boot.
        connector = "DP-1";
        resolution = {
          width = 3840;
          height = 2160;
        };
        inch = 27;
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

  kamino = {
    system = "aarch64-linux";
    stateVersion = "24.11";
  };

  yuta-mba = {
    system = "aarch64-darwin";
    darwinStateVersion = 5;
    stateVersion = "23.11";
  };
}
