{
  programs.nixvim.plugins.blink-cmp = {
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
        ];

        providers.lsp.fallbacks = [];
      };
    };
  };
}
