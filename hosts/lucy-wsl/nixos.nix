{pkgs, ...}: {
  optionalModules.nixos = {
    docker.enable = true;
    wsl.enable = true;
    tailscale.enable = true;
  };

  # Required by NixOS-WSL's VS Code Remote setup guide.
  # ref: https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  environment.systemPackages = with pkgs; [
    wget
  ];
  programs.nix-ld.enable = true;
}
