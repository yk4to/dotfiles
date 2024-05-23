{ pkgs, ... }: {
  # launch 1Password at login
  systemd.user.services._1password = {
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    Service = {
      SyslogIdentifier = "1password";
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      Restart = "on-failure";
    };
  };
}