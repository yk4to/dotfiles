{
  lib,
  config,
  inputs,
  vars,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.wsl;
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  options.optionalModules.nixos.wsl = {
    enable = mkEnableOption "WSL integration";
  };

  config = mkIf cfg.enable {
    wsl = {
      enable = true;

      defaultUser = vars.username;
      useWindowsDriver = true;
    };
  };
}
