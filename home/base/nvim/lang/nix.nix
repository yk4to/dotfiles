{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
    ];

    plugins.lsp.servers.nixd.enable = true;

    plugins.conform-nvim.settings = {
      formatters.alejandra.command = lib.getExe pkgs.alejandra;

      formatters_by_ft.nix = ["alejandra"];
    };
  };
}
