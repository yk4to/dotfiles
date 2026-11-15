{pkgs, ...}: {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
    ];

    lsp.servers.lua_ls = {
      enable = true;

      config.settings = {
        Lua = {
          diagnostics.globals = ["vim"];
          workspace.checkThirdParty = false;
        };
      };
    };
  };
}
