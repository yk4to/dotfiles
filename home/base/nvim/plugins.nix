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

  # cmp
  cmp-buffer
  cmp-cmdline
  cmp-nvim-lsp
  cmp-path
  cmp_luasnip
  copilot-cmp
  copilot-lua
  lspkind-nvim
  luasnip
  nvim-cmp

  # treesitter
  nvim-treesitter

  # editor
  neo-tree-nvim
  gitsigns-nvim
  which-key-nvim

  # ui
  lualine-nvim
  noice-nvim
  nui-nvim
  nvim-notify

  # dependencies
  nvim-web-devicons
  plenary-nvim
]