{ inputs, ... }: {
  environment.systemPackages = [
    inputs.ghostty.packages.x86_64-linux.default
  ];
}