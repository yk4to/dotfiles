{
  programs.waybar = {
    enable = true;

    settings = [
      {
        position = "top";
        height = 20;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "battery"
          "network"
        ];

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = {
            default = [""];
          };
          scroll-step = 5;
        };
        network = {
          format-wifi = "󰖩 {signalStrength}%";
          format-ethernet = "󰀂 ";
          tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰖪 ";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-icons = [" " " " " " " " " "];
          format-charging = "{capacity}%";
          format-full = "{capacity}%";
          format-warning = "{capacity}%";
          interval = 5;
          states = {
            warning = 20;
          };
          format-time = "{H}h{M}m";
          tooltip = true;
          tooltip-format = "{time}";
        };
      }
    ];

    style = builtins.readFile ./waybar.css;
    systemd.enable = true;
  };
}
