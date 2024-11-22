{
  inputs,
  mylib,
  vars,
  ...
}: {
  imports = mylib.scanPaths ./.;

  # enable experimental features
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [vars.username];
  };

  nixpkgs.config.allowUnfree = true;

  # enable nur
  nixpkgs.overlays = [
    inputs.nur.overlay
  ];
}
