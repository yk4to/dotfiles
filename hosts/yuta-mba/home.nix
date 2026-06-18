{
  optionalModules = {
    base = {
      ghostty.enable = true;
      inkdrop.enable = true;
      latex.enable = true;
      platformio.enable = true;
      vscode.enable = true;
    };
  };

  programs.ssh.settings = {
    tart = {
      HostName = "192.168.64.4";
      User = "yuta";
    };

    umiusi2 = {
      HostName = "umiusi2.local";
      User = "pi";
    };

    lucy-wsl = {
      HostName = "lucy-wsl";
      User = "yuta";
    };
  };
}
