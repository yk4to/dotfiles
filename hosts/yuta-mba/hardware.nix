{delib, ...}:
delib.host {
  name = "yuta-mba";

  system = "aarch64-darwin";

  darwin.system.stateVersion = 5;
  home = {
    home.stateVersion = "23.11";

    programs.ssh.extraConfig = ''
      Host tart
        HostName 192.168.64.4
        User yuta
      Host umiusi2
        HostName umiusi2.local
        User pi
    '';
  };
}
