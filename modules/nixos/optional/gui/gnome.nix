{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.gui.enable {
    # Enable gdm (GNOME Display Manager)
    services.xserver.displayManager.gdm.enable = true;

    # Enable GNOME
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      gnome-photos
      gnome-tour
      gnome-calendar
      gnome-connections
      gnome-music
      gnome-contacts
      gnome-maps
      gnome-characters
      gnome-logs
      gnome-calculator
      gnome-clocks
      gnome-weather
      gnome-text-editor
      gedit # text editor
      simple-scan # scanner
      yelp # help viewer
      epiphany # web browser
      geary # email reader
      evince # document viewer
      snapshot # camera
      xterm # terminal

      # totem # video player
      # loupe # image viewer
      # baobab # disk usage analyzer
      # gnome-disk-utility
      # gnome-system-monitor
      # gnome-font-viewer
      # seahorse # password manager
      # file-roller # archive manager
    ];
  };
}
