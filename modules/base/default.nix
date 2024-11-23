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
    trusted-users = ["root" vars.username];
    accept-flake-config = true;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://ghostty.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # enable nur
  nixpkgs.overlays = [
    inputs.nur.overlay
  ];
}
