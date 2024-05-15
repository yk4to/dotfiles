{ inputs, ... }: {
  environment.systemPackages = [
    inputs.ghostty.packages.x86_64-linux.default
  ];

  programs._1password-gui.enable = true;
}