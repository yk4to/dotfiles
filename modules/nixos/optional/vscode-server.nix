{
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.optionalModules.nixos.vscode-server;
in {
  imports = [inputs.vscode-server.nixosModules.default];

  options.optionalModules.nixos.vscode-server = {
    enable = mkEnableOption "Visual Studio Code Server support";
  };

  config = mkIf cfg.enable {
    services.vscode-server.enable = true;
  };
}
