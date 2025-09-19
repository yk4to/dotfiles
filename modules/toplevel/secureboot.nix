{
  delib,
  inputs,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "secureboot";

  options = delib.singleEnableOption false;

  nixos.always.imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixos.ifEnabled = {
    # ref: https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

    # NOTE: To install lanzaboote on a new machine,
    # we need to follow the install instruction for systemd-boot
    # and than switch to lanzaboote after the first boot.

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
      settings = {
        # the chosen entry will be saved and automatically selected the next time
        default = "@saved";
        # no menu is shown and the default entry will be booted immediately
        timeout = 0;
      };
    };
  };
}
