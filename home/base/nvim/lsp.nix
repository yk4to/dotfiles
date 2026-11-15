{
  programs.nixvim = {
    # Default server configs (cmd, filetypes, root markers) for `lsp.servers`
    plugins.lspconfig.enable = true;
    lsp.inlayHints.enable = true;
  };
}
