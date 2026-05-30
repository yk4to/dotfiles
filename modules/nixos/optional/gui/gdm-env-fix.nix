{
  config,
  lib,
  pkgs,
  ...
}: let
  xdmcfg = config.services.xserver.displayManager;
  env = config.services.displayManager.generic.environment;
  xSessionWrapper =
    if xdmcfg.setupCommands == ""
    then null
    else
      pkgs.writeScript "gdm-x-session-wrapper" ''
        #!${pkgs.bash}/bin/bash
        ${xdmcfg.setupCommands}
        exec "$@"
      '';
in {
  config = lib.mkIf config.services.displayManager.gdm.enable {
    # Temporary workaround for nixpkgs#523948 / nixpkgs#523332 until it lands upstream.
    security.pam.services.gdm-launch-environment.rules.session.env-greeter = {
      enable = true;
      order = 10250;
      control = "required";
      modulePath = "${config.security.pam.package}/lib/security/pam_env.so";
      settings = {
        conffile = pkgs.writeText "gdm-launch-environment-env-conf" (
          ''
            PATH                    DEFAULT="''${PATH}:${pkgs.gnome-session}/bin"
            XDG_DATA_DIRS           DEFAULT="''${XDG_DATA_DIRS}:${env.XDG_DATA_DIRS}"
            GDM_X_SERVER_EXTRA_ARGS DEFAULT="${env.GDM_X_SERVER_EXTRA_ARGS}"
          ''
          + lib.optionalString (xSessionWrapper != null) ''
            GDM_X_SESSION_WRAPPER   DEFAULT="${env.GDM_X_SESSION_WRAPPER}"
          ''
        );
        readenv = 0;
      };
    };
  };
}
