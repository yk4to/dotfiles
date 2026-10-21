{
  hostConfig,
  vars,
  pkgs,
  ...
}: {
  system.stateVersion = hostConfig.darwinStateVersion;

  nix.package = pkgs.nix;

  environment.variables.LANG = vars.locale;
}
