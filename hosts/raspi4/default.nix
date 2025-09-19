{delib, ...}:
delib.host {
  name = "raspi4";

  type = "server";
  rice = "onedark";

  features = [
    "cli"
  ];

  myconfig.containers.enable = true;
}
