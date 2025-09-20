{delib, ...}:
delib.module {
  name = "locale";

  nixos.always = {myconfig, ...}: {
    time.timeZone = myconfig.constants.timeZone;
    i18n.defaultLocale = myconfig.constants.locale;
  };

  darwin.always = {myconfig, ...}: {
    environment.variables.LANG = myconfig.constants.locale;
  };
}
