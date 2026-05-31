{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      bashls.enable = true;
      nixd.enable = true;
      yamlls.enable = true;

      lua_ls = {
        enable = true;

        settings = {
          Lua = {
            diagnostics.globals = ["vim"];
            workspace.checkThirdParty = false;
          };
        };
      };
    };
  };
}
