{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org/"
      "https://hyprland.cachix.org/"
      "https://ghostty.cachix.org/"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-for-delta.url = "github:NixOS/nixpkgs/195662d20d9c35f988d0122d34479f90da709e0a";

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
    ghostty-module.url = "github:clo4/ghostty-hm-module";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs: let
    vars = import ./vars.nix;
    args = {inherit inputs vars;};
  in {
    # ThinkPad
    nixosConfigurations = {
      thinkpad = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home/linux;
            home-manager.sharedModules = [inputs.ghostty-module.homeModules.default];
            home-manager.extraSpecialArgs =
              args
              // {
                pkgs-for-delta = import inputs.nixpkgs-for-delta {
                  system = "x86_64-linux";
                  config.permittedInsecurePackages = ["delta"];
                };
              };
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

          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home/darwin;
            home-manager.sharedModules = [inputs.ghostty-module.homeModules.default];
            home-manager.extraSpecialArgs =
              args
              // {
                pkgs-for-delta = import inputs.nixpkgs-for-delta {
                  system = "aarch64-darwin";
                  config.permittedInsecurePackages = ["delta"];
                };
              };
          }
        ];
        specialArgs = args;
      };
    };

    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter.aarch64-darwin = inputs.nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
