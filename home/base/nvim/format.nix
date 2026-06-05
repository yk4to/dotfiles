{config, ...}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };

        formatters_by_ft = {
          nix = ["alejandra"];
        };

        notify_on_error = false;
      };
    };

    keymaps = [
      {
        key = "<leader>cf";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end
        '';
        options.desc = "Format buffer";
      }
    ];
  };
}
