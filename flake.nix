{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    niri-flake.url = "github:sodiboo/niri-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nix-inkdrop.url = "git+ssh://git@github.com/yk4to/nix-inkdrop?ref=support-v6";

    nur.url = "github:nix-community/nur";

    agenix.url = "github:yaxitech/ragenix";

    secrets = {
      url = "git+ssh://git@github.com/yk4to/nix-secrets";
      flake = false;
    };

    rss-generator.url = "git+ssh://git@github.com/yk4to/rss-generator";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";
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
      inherit (inputs.nixpkgs) lib;
    in {
      formatter = pkgs.alejandra;
      checks =
        if pkgs.stdenv.isDarwin
        then lib.mapAttrs (_: config: config.system) hosts.darwin
        else lib.mapAttrs (_: config: config.config.system.build.toplevel) hosts.nixos;
    });
}
