{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:mitchellh/ghostty";

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";
  };

  outputs = inputs: {
    # ThinkPad
    nixosConfigurations = {
      thinkpad = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad

          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yuta = import ./home/linux;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };

    # MacBook
    darwinConfigurations = {
      yuta-mba = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook

          inputs.darwin-custom-icons.darwinModules.default

          inputs.home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yuta = import ./home/darwin;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
