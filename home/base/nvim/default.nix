{pkgs, ...}: let
  # ref: https://github.com/natsukium/dotfiles/blob/main/nix/applications/nvim/default.nix
  plugins = import ./plugins.nix { inherit pkgs; };
  configFile = file: {
    "nvim/${file}".source = pkgs.substituteAll (
      {
        src = ./. + "/${file}";
      }
      // plugins
    );
  };
  configFiles = files: builtins.foldl' (x: y: x // y) { } (map configFile files);
in {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    defaultEditor = true;
  };

  xdg.configFile = configFiles [
    "./init.lua"
    "./lua/plugins/colorscheme.lua"
    "./lua/plugins/ui.lua"
  ];
}