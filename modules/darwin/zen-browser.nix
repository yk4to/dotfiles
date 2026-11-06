{
  config,
  inputs,
  lib,
  system,
  vars,
  ...
}: let
  zenEnabled = config.home-manager.users.${vars.username}.optionalModules.base.zen-browser.enable;
in {
  # Copied into /Applications/Nix Apps, keeping the upstream signature.
  environment.systemPackages = lib.mkIf zenEnabled [
    inputs.zen-browser.packages.${system}.beta-unwrapped
  ];

  # Use the profile in the read-only profiles.ini, as the Linux wrapper does.
  launchd.user.envVariables = lib.mkIf zenEnabled {
    MOZ_LEGACY_PROFILES = "1";
  };
}
