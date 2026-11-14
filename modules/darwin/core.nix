{
  hostConfig,
  vars,
  ...
}: {
  system.stateVersion = hostConfig.darwinStateVersion;

  environment.variables.LANG = vars.locale;
}
