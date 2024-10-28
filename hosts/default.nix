inputs: let
  vars = import ../vars.nix;

  mkSystem = {
    system,
    modules,
    homeManagerModules,
  }: let
    isDarwin = builtins.elem "darwin" (builtins.split "-" system);
  in
    (
      if isDarwin
      then inputs.nix-darwin.lib.darwinSystem
      else inputs.nixpkgs.lib.nixosSystem
    ) {
      inherit system;
      modules =
        modules
        ++ [
          (
            if isDarwin
            then inputs.home-manager.darwinModules.home-manager
            else inputs.home-manager.nixosModules.home-manager
          )
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${vars.username} = homeManagerModules;

              sharedModules = [inputs.ghostty-module.homeModules.default];
              extraSpecialArgs = {inherit inputs vars;};
            };
          }
          (
            if isDarwin
            then inputs.agenix.darwinModules.default
            else inputs.agenix.nixosModules.default
          )
        ];
      specialArgs = {inherit inputs vars system;};
    };
in {
  nixos = {
    thinkpad = mkSystem {
      system = "x86_64-linux";
      modules = [./thinkpad/nixos.nix];
      homeManagerModules = import ./thinkpad/home-manager.nix;
    };
    raspi4 = mkSystem {
      system = "aarch64-linux";
      modules = [
        inputs.raspberry-pi-nix.nixosModules.raspberry-pi
        ./raspi4/nixos.nix
      ];
      homeManagerModules = import ./raspi4/home-manager.nix;
    };
  };

  darwin = {
    "yuta-mba" = mkSystem {
      system = "aarch64-darwin";
      modules = [
        ./yuta-mba/darwin.nix
        inputs.darwin-custom-icons.darwinModules.default
      ];
      homeManagerModules = import ./yuta-mba/home-manager.nix;
    };
  };
}
