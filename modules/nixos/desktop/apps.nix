{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.ghostty.packages.x86_64-linux.default
    pkgs.firefox-devedition
  ];

  programs._1password-gui.enable = true;
}