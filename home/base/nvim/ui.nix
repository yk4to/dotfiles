{config, ...}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;

      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
          cmp = true;
          gitsigns = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    plugins = {
      web-devicons.enable = true;

      fidget.enable = true;
      # render-markdown.enable = true;
      smear-cursor.enable = true;
      tiny-inline-diagnostic.enable = true;

      lualine = {
        enable = true;

        settings = {
          options = {
            globalstatus = true;
            theme = "catppuccin-nvim";
          };

          sections = {
            lualine_c = ["filename"];
            lualine_x = [
              "diagnostics"
              "encoding"
              (helpers.mkRaw ''
                function()
                  local ok, conform = pcall(require, "conform")
                  if not ok then
                    return ""
                  end

                  local formatters = conform.list_formatters_to_run(vim.api.nvim_get_current_buf())
                  if not formatters or vim.tbl_isempty(formatters) then
                    return ""
                  end

                  local names = {}
                  local seen = {}
                  for _, formatter in ipairs(formatters) do
                    if formatter.available and formatter.name and not seen[formatter.name] then
                      table.insert(names, formatter.name)
                      seen[formatter.name] = true
                    end
                  end

                  if vim.tbl_isempty(names) then
                    return ""
                  end

                  return "fmt: " .. table.concat(names, ", ")
                end
              '')
              "filetype"
            ];
          };
        };
      };

      which-key.enable = true;
    };
  };
}
