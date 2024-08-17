{
  inputs,
  pkgs,
  system,
  ...
}: {
  environment.systemPackages = [
    inputs.ghostty.packages.${system}.default
    pkgs.firefox-devedition
  ];

  programs._1password-gui.enable = true;
}
