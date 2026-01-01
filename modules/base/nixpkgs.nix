{
  system,
  inputs,
  ...
}: {
  nixpkgs = {
    hostPlatform = system;

    config.allowUnfree = true;

    # enable nur
    overlays = [inputs.nur.overlays.default];
  };
}
