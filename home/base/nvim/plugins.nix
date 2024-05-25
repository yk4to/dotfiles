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

  # completion
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

  # lsp
  nvim-lspconfig
  none-ls-nvim

  # treesitter
  nvim-treesitter

  # editor
  neo-tree-nvim
  gitsigns-nvim
  nvim-colorizer-lua
  which-key-nvim
  toggleterm-nvim

  # ui
  lualine-nvim
  barbar-nvim
  fidget-nvim
  noice-nvim
  nui-nvim
  nvim-notify

  # dependencies
  nvim-web-devicons
  plenary-nvim
]