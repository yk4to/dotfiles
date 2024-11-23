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

    flake-utils.url = "github:numtide/flake-utils";

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
    ghostty-module.url = "github:clo4/ghostty-hm-module";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nur.url = "github:nix-community/nur";

    arion.url = "github:hercules-ci/arion";

    agenix.url = "github:yaxitech/ragenix";

    deploy-rs.url = "github:serokell/deploy-rs";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "git+ssh://git@github.com/yk4to/nix-secrets";
      flake = false;
    };
  };

  outputs = inputs: let
    hosts = import ./hosts inputs;
  in
    {
      nixosConfigurations = hosts.nixos;
      darwinConfigurations = hosts.darwin;

      deploy = {
        user = "root";

        autoRollback = true;
        magicRollback = true;

        remoteBuild = true;

        nodes.raspi4 = {
          hostname = "raspi4";
          profiles.system.path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos hosts.nixos.raspi4;
        };
      };

      # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks inputs.self.deploy) inputs.deploy-rs.lib;
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        buildInputs = [pkgs.deploy-rs];
      };
    });
}
