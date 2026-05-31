{config, ...}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim.plugins.cmp = {
    enable = true;

    settings = {
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };

      snippet.expand = helpers.mkRaw ''
        function(args)
          vim.snippet.expand(args.body)
        end
      '';

      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];
    };
  };
}
