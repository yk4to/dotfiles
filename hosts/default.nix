inputs: let
  inherit (inputs.nixpkgs) lib;
  machines = import ./machines.nix;
  mkSystems = import ./lib/mk-systems.nix {
    inherit inputs lib machines;
  };

  isDarwin = _: cfg: lib.strings.hasSuffix "darwin" cfg.system;
  isLinux = name: cfg: !(isDarwin name cfg);
in {
  nixos = mkSystems (lib.filterAttrs isLinux machines);
  darwin = mkSystems (lib.filterAttrs isDarwin machines);
}
