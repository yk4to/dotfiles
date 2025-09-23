{
  config,
  lib,
  mylib,
  vars,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.docker;
in {
  options.optionalModules.nixos.docker = {
    enable = mkEnableOption "Docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${vars.username}.extraGroups = ["docker"];
  };
}
