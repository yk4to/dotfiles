{
  home.stateVersion = "23.11";

  optionalModules = {
    base = {
      ghostty.enable = true;
      inkdrop.enable = true;
      latex.enable = true;
      platformio.enable = true;
      vscode.enable = true;
    };
  };

  programs.ssh.extraConfig = ''
    Host tart
      HostName 192.168.64.4
      User yuta
    Host umiusi2
      HostName umiusi2.local
      User pi
  '';
}
