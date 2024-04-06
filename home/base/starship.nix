{pkgs, lib, ...}: {
  programs.starship = {
    enable = true;

    # disable fish integration to load starship manually
    enableFishIntegration = false;

    settings = lib.mkMerge [
      (builtins.fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/nerd-font-symbols.toml"))
      {
        add_newline = true;
        command_timeout = 5000;
      }
    ];
  };
}