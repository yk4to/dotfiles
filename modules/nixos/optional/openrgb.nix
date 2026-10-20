{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.openrgb;
in {
  options.optionalModules.nixos.openrgb = {
    enable = mkEnableOption "OpenRGB for RGB lighting control";
  };

  config = mkIf cfg.enable {
    # Runs the OpenRGB SDK server as root, so that it can access SMBus (RAM)
    # and GPU I2C buses. The GUI connects to it as a client.
    # `motherboard` is inferred from the CPU microcode setting (amd -> i2c-piix4).
    services.hardware.openrgb.enable = true;
  };
}
