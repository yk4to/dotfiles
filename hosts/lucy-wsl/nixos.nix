{...}: {
  optionalModules.nixos = {
    docker.enable = true;
    wsl.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };
}
