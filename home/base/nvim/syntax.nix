{pkgs, ...}: {
  programs.nixvim.plugins.treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      markdown
      markdown_inline
      nix
      query
      regex
      toml
      vim
      vimdoc
      yaml
    ];

    folding.enable = true;
    highlight.enable = true;
    indent.enable = true;
  };
}
