{...}: {
  optionalModules.nixos = {
    wsl.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };
}
