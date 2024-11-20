{
  inputs,
  pkgs,
  system,
  ...
}: {
  environment.systemPackages = [
    inputs.ghostty.packages.${system}.default
  ];
}
