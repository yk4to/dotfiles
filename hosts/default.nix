inputs: let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib {inherit lib;};
  vars = import ../vars.nix;

  mkSystem = {
    hostName,
    system,
  }: let
    isDarwin = builtins.elem "darwin" (builtins.split "-" system);
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
in {
  nixos = {
    thinkpad = mkSystem {
      hostName = "thinkpad";
      system = "x86_64-linux";
    };

    x230 = mkSystem {
      hostName = "x230";
      system = "x86_64-linux";
    };

    mate = mkSystem {
      hostName = "mate";
      system = "x86_64-linux";
    };

    raspi4 = mkSystem {
      hostName = "raspi4";
      system = "aarch64-linux";
    };
  };

  darwin = {
    yuta-mba = mkSystem {
      hostName = "yuta-mba";
      system = "aarch64-darwin";
    };
  };
}
