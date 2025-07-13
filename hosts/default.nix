inputs: let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib {inherit lib;};
  vars = import ../vars.nix;

  mkSystem = {
    system,
    modules,
    homeManagerModules,
  }: let
    isDarwin = builtins.elem "darwin" (builtins.split "-" system);
    moduleName =
      if isDarwin
      then "darwinModules"
      else "nixosModules";

    baseModules = [
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
          users.${vars.username} = {
            imports =
              homeManagerModules
              ++ [
                (
                  if isDarwin
                  then ../home/darwin
                  else ../home/linux
                )
              ];
          };

          extraSpecialArgs = {inherit inputs mylib vars system isDarwin;};
        };
      }
    ];
  in
    (
      if isDarwin
      then inputs.nix-darwin.lib.darwinSystem
      else inputs.nixpkgs.lib.nixosSystem
    ) {
      inherit system;
      modules = baseModules ++ modules;
      specialArgs = {inherit inputs mylib vars system isDarwin;};
    };
in {
  nixos = {
    thinkpad = mkSystem {
      system = "x86_64-linux";
      modules = [./thinkpad/nixos.nix];
      homeManagerModules = [./thinkpad/home-manager.nix];
    };
    x230 = mkSystem {
      system = "x86_64-linux";
      modules = [./x230/nixos.nix];
      homeManagerModules = [./x230/home-manager.nix];
    };
    raspi4 = mkSystem {
      system = "aarch64-linux";
      modules = [./raspi4/nixos.nix];
      homeManagerModules = [./raspi4/home-manager.nix];
    };
  };

  darwin = {
    "yuta-mba" = mkSystem {
      system = "aarch64-darwin";
      modules = [./yuta-mba/darwin.nix];
      homeManagerModules = [./yuta-mba/home-manager.nix];
    };
  };
}
