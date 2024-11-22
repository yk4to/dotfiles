{lib, ...}: {
  # ref: https://github.com/ryan4yin/nix-config/blob/main/lib/default.nix

  attrs = import ./attrs.nix {inherit lib;};

  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (
              (_type == "directory") # include directories
              && (path != "optional") # ignore optional
            )
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
            )
        )
        (builtins.readDir path)));
}
