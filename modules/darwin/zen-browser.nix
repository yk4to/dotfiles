{
  config,
  lib,
  vars,
  ...
}: {
  # Use the profile in the read-only profiles.ini, as the Linux wrapper does.
  launchd.user.envVariables = lib.mkIf config.home-manager.users.${vars.username}.optionalModules.base.zen-browser.enable {
    MOZ_LEGACY_PROFILES = "1";
  };
}
