{pkgs, ...}: {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
    ];

    plugins.lsp.servers.lua_ls = {
      enable = true;

      settings = {
        Lua = {
          diagnostics.globals = ["vim"];
          workspace.checkThirdParty = false;
        };
      };
    };
  };
}
