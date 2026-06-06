{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;

      settings = {
        keymap = {
          preset = "default";
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<C-e>" = [
            "cancel"
            "fallback"
          ];
        };

        completion.documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };

        sources = {
          default = [
            "lsp"
            "path"
            "buffer"
            "copilot"
          ];

          providers = {
            copilot = {
              async = true;
              module = "blink-copilot";
              name = "copilot";
              score_offset = 100;
              # Keep Copilot items out of blink's auto docs popup while preserving
              # auto documentation for LSP and other sources.
              transform_items.__raw = ''
                function(_, items)
                  for _, item in ipairs(items) do
                    item.documentation = nil
                    item.detail = nil
                  end
                  return items
                end
              '';
            };

            lsp.fallbacks = [];
          };
        };
      };
    };

    blink-copilot.enable = true;

    copilot-lua = {
      enable = true;

      settings = {
        panel.enabled = false;
        suggestion.enabled = false;
      };
    };
  };
}
