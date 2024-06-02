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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";

    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
  };

  outputs = inputs: let
    vars = import ./vars.nix;
    args = { inherit inputs vars; };
  in {
    # ThinkPad
    nixosConfigurations = {
      thinkpad = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad

          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home/linux;
            home-manager.extraSpecialArgs = args;
          }
        ];
        specialArgs = args;
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
            home-manager.users.${vars.username} = import ./home/darwin;
            home-manager.extraSpecialArgs = args;
          }
        ];
        specialArgs = args;
      };
    };
  };
}
