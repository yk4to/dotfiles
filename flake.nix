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

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "nix-darwin";
    };

    flake-utils.url = "github:numtide/flake-utils";

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nix-inkdrop.url = "git+ssh://git@github.com/yk4to/nix-inkdrop";

    nur.url = "github:nix-community/nur";

    agenix.url = "github:yaxitech/ragenix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
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

  outputs = {denix, ...} @ inputs: let
    mkConfigurations = moduleSystem:
      denix.lib.configurations {
        inherit moduleSystem;
        homeManagerUser = "yuta";

        paths = [
          ./hosts
          ./modules
          ./rices
        ];

        extensions = with denix.lib.extensions; [
          args
          (base.withConfig {
            args.enable = true;
            # cli: not must-have (ssh, git, ...) utilities like eza, bat, etc.
            # gui: gui applications and modules that are needed only for gui applications (gnome-keyring, ...)
            # electronics: for programming microcontrollers (platformio, ...)
            # academic: for academic works (LaTeX, ...)
            hosts.features.features = [
              "cli"
              "gui"
              "electronics"
              "academic"
            ];
          })
        ];

        specialArgs = {
          inherit inputs;
        };
      };
  in
    {
      nixosConfigurations = mkConfigurations "nixos";
      darwinConfigurations = mkConfigurations "darwin";
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    });
}
