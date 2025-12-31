{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;

    settings = lib.mkMerge [
      (fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/nerd-font-symbols.toml"))
      {
        add_newline = true;
        command_timeout = 5000;
      }
    ];
  };
}
