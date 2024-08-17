inputs: let
  vars = import ../vars.nix;

  mkSystem = {
    system,
    modules,
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
              users.${vars.username} =
                if isDarwin
                then import ../home/darwin
                else import ../home/linux;

              sharedModules = [inputs.ghostty-module.homeModules.default];
              extraSpecialArgs = {
                inherit inputs vars;

                # TODO: This is a patch needed while delta is broken on nixpkgs-unstable branch
                # When that's fixed, this will be unnecessary.
                pkgs-for-delta = import inputs.nixpkgs-for-delta {
                  inherit system;
                  config.permittedInsecurePackages = ["delta"];
                };
              };
            };
          }
        ];
      specialArgs = {inherit inputs vars;};
    };
in {
  nixos = {
    thinkpad = mkSystem {
      system = "x86_64-linux";
      modules = [./thinkpad];
    };
  };

  darwin = {
    "yuta-mba" = mkSystem {
      system = "aarch64-darwin";
      modules = [
        ./yuta-mba
        inputs.darwin-custom-icons.darwinModules.default
      ];
    };
  };
}
