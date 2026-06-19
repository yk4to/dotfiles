{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    import-tree.url = "github:denful/import-tree";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim.url = "github:nix-community/nixvim";

    catppuccin.url = "github:catppuccin/nix";

    niri-flake.url = "github:sodiboo/niri-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents.url = "github:numtide/llm-agents.nix";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nix-hazkey = {
      url = "github:aster-void/nix-hazkey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-inkdrop.url = "git+ssh://git@github.com/yk4to/nix-inkdrop?ref=support-v6";

    nur.url = "github:nix-community/nur";

    agenix.url = "github:yaxitech/ragenix";

    secrets = {
      url = "git+ssh://git@github.com/yk4to/nix-secrets";
      flake = false;
    };

    rss-generator.url = "git+ssh://git@github.com/yk4to/rss-generator";

    private-assets = {
      url = "git+ssh://git@github.com/yk4to/private-assets?ref=main";
      flake = false;
    };

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

      hostsForSystem = hostConfigs:
        lib.filterAttrs (_: host: host.pkgs.stdenv.hostPlatform.system == system) hostConfigs;

      mkDarwinChecks = hostConfigs:
        lib.mapAttrs (_: host: host.system) (hostsForSystem hostConfigs);
      mkNixosChecks = hostConfigs:
        lib.mapAttrs (_: host: host.config.system.build.toplevel) (hostsForSystem hostConfigs);
    in {
      formatter = pkgs.alejandra;
      checks =
        if pkgs.stdenv.isDarwin
        then mkDarwinChecks hosts.darwin
        else mkNixosChecks hosts.nixos;
    });
}
