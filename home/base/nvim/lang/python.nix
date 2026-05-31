{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python
    ];

    plugins.lsp.servers.pylsp = {
      enable = true;

      settings = {
        pylsp.plugins = {
          autopep8.enabled = false;
          mccabe.enabled = false;
          pycodestyle.enabled = false;
          pyflakes.enabled = false;
          ruff = {
            enabled = true;
            executable = lib.getExe pkgs.ruff;
          };
          yapf.enabled = false;
        };
      };
    };

    plugins.conform-nvim.settings = {
      formatters = {
        black.command = lib.getExe pkgs.black;
        isort.command = lib.getExe pkgs.isort;
      };

      formatters_by_ft.python = [
        "isort"
        "black"
      ];
    };
  };
}
