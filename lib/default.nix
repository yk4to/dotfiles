{lib, ...}: {
  # ref: https://github.com/ryan4yin/nix-config/blob/main/lib/default.nix

  attrs = import ./attrs.nix {inherit lib;};

  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          # Filtering logic for files and directories in a path:
          name: _type:
          # Exclude files/directories starting with "_"
            (!(lib.strings.hasPrefix "_" name))
            && (
              (_type == "directory") # include directories
              || (
                (name != "default.nix") # exclude default.nix
                && (lib.strings.hasSuffix ".nix" name) # include .nix files
              )
            )
        )
        (builtins.readDir path)));
}
