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

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nix-inkdrop.url = "git+ssh://git@github.com/yk4to/nix-inkdrop?ref=support-v6";

    nur.url = "github:nix-community/nur";

    agenix.url = "github:yaxitech/ragenix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "git+ssh://git@github.com/yk4to/nix-secrets";
      flake = false;
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Declarative homebrew tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs: let
    hosts = import ./hosts inputs;
  in
    {
      nixosConfigurations = hosts.nixos;
      darwinConfigurations = hosts.darwin;
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    });
}
