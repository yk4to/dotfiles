{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.xserver";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
