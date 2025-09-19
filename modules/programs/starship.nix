{
  delib,
  pkgs,
  lib,
  host,
  ...
}:
delib.module {
  name = "programs.starship";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.programs.starship = {
    enable = true;

    settings = lib.mkMerge [
      (builtins.fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/nerd-font-symbols.toml"))
      {
        add_newline = true;
        command_timeout = 5000;
      }
    ];
  };
}
