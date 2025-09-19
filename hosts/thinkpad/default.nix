{delib, ...}:
delib.host {
  name = "thinkpad";

  type = "laptop";
  rice = "onedark";

  features = [
    "cli"
    "gui"
  ];

  myconfig.secureboot.enable = true;
}
