{
  config,
  pkgs,
  lib,
  ...
}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      json
      tsx
      typescript
    ];

    plugins.lsp.servers.vtsls.enable = true;

    plugins.conform-nvim.settings = {
      formatters = {
        biome = {
          command = lib.getExe pkgs.biome;
          cwd = helpers.mkRaw ''
            require("conform.util").root_file({ "biome.json", "biome.jsonc" })
          '';
          require_cwd = true;
        };
        prettierd = {
          command = lib.getExe pkgs.prettierd;
          cwd = helpers.mkRaw ''
            require("conform.util").root_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.json5",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
              "prettier.config.ts",
              "prettier.config.cts",
              "prettier.config.mts"
            })
          '';
          require_cwd = true;
        };
        prettier = {
          command = lib.getExe pkgs.prettier;
          cwd = helpers.mkRaw ''
            require("conform.util").root_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.json5",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
              "prettier.config.ts",
              "prettier.config.cts",
              "prettier.config.mts"
            })
          '';
          require_cwd = true;
        };
      };

      formatters_by_ft = {
        javascript = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
        json = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
        jsonc = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        };
      };
    };
  };
}
