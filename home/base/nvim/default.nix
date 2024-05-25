{pkgs, ...}: let
  # ref: https://zenn.dev/natsukium/articles/b4899d7b1e6a9a#lazy.nvimとnixを使った私の環境
  # ref: https://github.com/natsukium/dotfiles/blob/main/nix/applications/nvim/default.nix
  lsp = with pkgs; [
    # javascript
    biome
    # lua
    lua-language-server
    stylua
    # nix
    nil
  ];
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

    extraPackages = lsp;
  };

  xdg.configFile = configFiles [
    "./init.lua"
    "./lua/plugins/coding.lua"
    "./lua/plugins/colorscheme.lua"
    "./lua/plugins/ui.lua"
  ];
}