{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      markdown
      markdown_inline
      query
      regex
      toml
      vim
      vimdoc
      yaml
    ];

    plugins.lsp.servers = {
      bashls.enable = true;
      yamlls.enable = true;
    };

    plugins.conform-nvim.settings = {
      formatters.prettier_markdown = {
        command = lib.getExe pkgs.prettier;
        args = [
          "--stdin-filepath"
          "$FILENAME"
        ];
      };

      formatters_by_ft.markdown = ["prettier_markdown"];
    };
  };
}
