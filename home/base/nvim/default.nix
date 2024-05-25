{pkgs, ...}: let
  # ref: https://zenn.dev/natsukium/articles/b4899d7b1e6a9a#lazy.nvimとnixを使った私の環境
  # ref: https://github.com/natsukium/dotfiles/blob/main/nix/applications/nvim/default.nix
  lsp = with pkgs; [
    # astro
    nodePackages."@astrojs/language-server"
    shellcheck
    shfmt
    # bash
    nodePackages.bash-language-server
    # javascript
    biome
    # lua
    lua-language-server
    stylua
    # nix
    nil
    # yaml
    yaml-language-server
  ];
  parsers = p: with p; [
    astro
    bash
    c
    css
    dockerfile
    fish
    lua
    markdown
    markdown_inline
    nix
    python
    rust
    toml
    tsx
    typescript
    tree-sitter-typst
    vim
    vimdoc
    yaml
  ];

  plugins = import ./plugins.nix { inherit pkgs; };
  configFile = file: {
    "nvim/${file}".source = pkgs.substituteAll (
      {
        src = ./. + "/${file}";
        ts_parser_dirs = pkgs.lib.pipe (pkgs.vimPlugins.nvim-treesitter.withPlugins parsers).dependencies [
          (map toString)
          (builtins.concatStringsSep ",")
        ];
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