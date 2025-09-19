{
  delib,
  inputs,
  ...
}: let
  config = {
    nixpkgs = {
      config.allowUnfree = true;

      # enable nur
      overlays = [
        inputs.nur.overlays.default
      ];
    };
  };
in
  delib.module {
    name = "nixpkgs";

    nixos.always.nixpkgs = config;
    darwin.always.nixpkgs = config;
  }
