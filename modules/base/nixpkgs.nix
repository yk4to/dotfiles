{
  system,
  inputs,
  ...
}: {
  nixpkgs = {
    hostPlatform = system;

    config.allowUnfree = true;

    overlays = [
      inputs.nur.overlays.default
      inputs.nix-vscode-extensions.overlays.default
    ];
  };
}
