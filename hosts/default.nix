inputs: let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib {inherit lib;};
  vars = import ../vars.nix;

  mkSystem = hostName: {system}: let
    isDarwin = lib.strings.hasSuffix "darwin" system;
    moduleName =
      if isDarwin
      then "darwinModules"
      else "nixosModules";

    hostDir = ./. + "/${hostName}";

    baseModules = [
      ../modules/base
      (
        if isDarwin
        then ../modules/darwin
        else ../modules/nixos
      )
      inputs.agenix.${moduleName}.default
      inputs.home-manager.${moduleName}.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${vars.username}.imports = [
            ../home/base
            (
              if isDarwin
              then ../home/darwin
              else ../home/linux
            )
            (hostDir + "/home-manager.nix")
          ];

          sharedModules = [
            inputs.nix-inkdrop.homeModules.default
          ];

          extraSpecialArgs = {
            inherit inputs mylib vars system isDarwin hostName;
          };
        };
      }
    ];

    hostModule =
      if isDarwin
      then hostDir + "/darwin.nix"
      else hostDir + "/nixos.nix";
  in
    (
      if isDarwin
      then inputs.nix-darwin.lib.darwinSystem
      else inputs.nixpkgs.lib.nixosSystem
    ) {
      inherit system;
      modules = baseModules ++ [hostModule];
      specialArgs = {
        inherit inputs mylib vars system isDarwin hostName;
      };
    };

  mkSystems = lib.mapAttrs mkSystem;
in {
  nixos = mkSystems {
    x13 = {
      system = "x86_64-linux";
    };

    x230 = {
      system = "x86_64-linux";
    };

    mate = {
      system = "x86_64-linux";
    };
  };

  darwin = mkSystems {
    yuta-mba = {
      system = "aarch64-darwin";
    };
  };
}
