{pkgs, ...}: let
  # ref: https://github.com/natsukium/dotfiles/blob/main/nix/applications/nvim/plugins.nix
  normalizedPluginAttr = p: {
    "${builtins.replaceStrings
      [
        "-"
        "."
      ]
      [
        "_"
        "_"
      ]
      (pkgs.lib.toLower p.pname)}" = p;
  };
  plugins = p: builtins.foldl' (x: y: x // y) { } (map normalizedPluginAttr p);
in with pkgs.vimPlugins; plugins [
  # plugin manager
  lazy-nvim
  
  # colorscheme
  onedarkpro-nvim

  # ui
  lualine-nvim
  noice-nvim
  nui-nvim
  nvim-notify

  nvim-web-devicons
]