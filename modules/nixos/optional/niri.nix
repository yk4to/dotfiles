{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.niri;
in {
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  options.optionalModules.nixos.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite-unstable
    ];
  };
}
