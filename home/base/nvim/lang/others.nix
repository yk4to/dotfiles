{pkgs, ...}: {
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
  };
}
