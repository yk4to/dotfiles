{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.nvidia;
in {
  options.optionalModules.nixos.nvidia = {
    enable = mkEnableOption "NVIDIA proprietary driver";
  };

  config = mkIf cfg.enable {
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      # Required by Wayland compositors.
      modesetting.enable = true;

      # Open kernel modules are recommended for Turing and newer GPUs.
      open = true;

      # Save VRAM contents on suspend to avoid graphical corruption after resume.
      powerManagement.enable = true;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Work around excessive VRAM usage of niri on NVIDIA.
    # ref: https://github.com/YaLTeR/niri/wiki/Nvidia
    environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json" = mkIf config.optionalModules.nixos.niri.enable {
      text = builtins.toJSON {
        rules = [
          {
            pattern = {
              feature = "procname";
              matches = "niri";
            };
            profile = "Limit Free Buffer Pool On Wayland Compositors";
          }
        ];
        profiles = [
          {
            name = "Limit Free Buffer Pool On Wayland Compositors";
            settings = [
              {
                key = "GLVidHeapReuseRatio";
                value = 0;
              }
            ];
          }
        ];
      };
    };
  };
}
