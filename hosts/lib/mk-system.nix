{
  inputs,
  lib,
}: let
  mylib = import ../../lib {inherit lib;};
  vars = import ../../vars.nix;

  optionalImport = path:
    lib.optional (builtins.pathExists path) path;

  mkSystem = hostName: {system, ...} @ hostConfig: let
    isDarwin = lib.strings.hasSuffix "darwin" system;
    moduleName =
      if isDarwin
      then "darwinModules"
      else "nixosModules";

    hostDir = ../. + "/${hostName}";

    specialArgs = {
      inherit inputs vars system isDarwin hostName hostConfig mylib;
    };

    modules =
      [
        (inputs.import-tree ../../modules/base)
        (
          if isDarwin
          then (inputs.import-tree ../../modules/darwin)
          else (inputs.import-tree ../../modules/nixos)
        )
        inputs.agenix.${moduleName}.default
        inputs.home-manager.${moduleName}.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.${vars.username}.imports =
              [
                (inputs.import-tree ../../home/base)
                (
                  if isDarwin
                  then (inputs.import-tree ../../home/darwin)
                  else (inputs.import-tree ../../home/linux)
                )
              ]
              ++ optionalImport (hostDir + "/home.nix");

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
in
  lib.mapAttrs mkSystem
