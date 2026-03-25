inputs: let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib {inherit lib;};
  vars = import ../vars.nix;

  optionalImport = path:
    lib.optional (builtins.pathExists path) path;

  mkSystem = hostName: {system, ...} @ hostConfig: let
    isDarwin = lib.strings.hasSuffix "darwin" system;
    moduleName =
      if isDarwin
      then "darwinModules"
      else "nixosModules";

    hostDir = ./. + "/${hostName}";

    specialArgs = {
      inherit inputs mylib vars system isDarwin hostName hostConfig;
    };

    modules =
      [
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

            users.${vars.username}.imports =
              [
                ../home/base
                (
                  if isDarwin
                  then ../home/darwin
                  else ../home/linux
                )
              ]
              ++ optionalImport (hostDir + "/home-manager.nix");

            sharedModules = [
              inputs.nix-inkdrop.homeModules.default
            ];

            extraSpecialArgs = specialArgs;
          };
        }
      ]
      ++ (
        if isDarwin
        then optionalImport (hostDir + "/darwin.nix")
        else optionalImport (hostDir + "/nixos.nix")
      );
  in
    (
      if isDarwin
      then inputs.nix-darwin.lib.darwinSystem
      else inputs.nixpkgs.lib.nixosSystem
    ) {
      inherit system modules specialArgs;
    };

  mkSystems = lib.mapAttrs mkSystem;
in {
  nixos = mkSystems {
    x13 = {
      system = "x86_64-linux";
      stateVersion = "25.05";
    };

    x230 = {
      system = "x86_64-linux";
      stateVersion = "25.05";
    };

    mate = {
      system = "x86_64-linux";
      stateVersion = "25.05";
    };
  };

  darwin = mkSystems {
    yuta-mba = {
      system = "aarch64-darwin";
      darwinStateVersion = 5;
      stateVersion = "23.11";
    };
  };
}
