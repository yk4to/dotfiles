{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.secureboot;
in {
  options.modules.nixos.secureboot = {
    enable = mkEnableOption "Secure Boot";
  };

  config = mkIf cfg.enable {
    # ref: https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    # NOTE: To install lanzaboote on a new machine,
    # we need to follow the install instruction for systemd-boot
    # and than switch to lanzaboote after the first boot.

    imports = [
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

    environment.systemPackages = [
      # For debugging and troubleshooting Secure Boot.
      pkgs.sbctl
    ];

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
