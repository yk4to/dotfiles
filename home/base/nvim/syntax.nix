{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    # Language modules append only the grammars they need.
    grammarPackages = [];

    folding.enable = true;
    highlight.enable = true;
    indent.enable = true;
  };
}
