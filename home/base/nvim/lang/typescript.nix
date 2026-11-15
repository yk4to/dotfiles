{
  config,
  pkgs,
  lib,
  ...
}: let
  helpers = config.lib.nixvim;

  rootFile = files: helpers.mkRaw "require(\"conform.util\").root_file(${helpers.toLuaObject files})";

  prettierConfigs = [
    ".editorconfig"
    ".prettierrc"
    ".prettierrc.json"
    ".prettierrc.json5"
    ".prettierrc.yml"
    ".prettierrc.yaml"
    ".prettierrc.js"
    ".prettierrc.cjs"
    ".prettierrc.mjs"
    ".prettierrc.toml"
    "prettier.config.js"
    "prettier.config.cjs"
    "prettier.config.mjs"
    "prettier.config.ts"
    "prettier.config.cts"
    "prettier.config.mts"
  ];
in {
  programs.nixvim = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      json
      tsx
      typescript
    ];

    lsp.servers.vtsls.enable = true;
    plugins.ts-context-commentstring.enable = true;
    plugins.comment.settings.pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";

    plugins.conform-nvim.settings = {
      formatters = {
        biome = {
          command = lib.getExe pkgs.biome;
          cwd = rootFile ["biome.json" "biome.jsonc"];
          require_cwd = true;
        };
        prettierd = {
          command = lib.getExe pkgs.prettierd;
          cwd = rootFile prettierConfigs;
          require_cwd = true;
        };
        prettier = {
          command = lib.getExe pkgs.prettier;
          cwd = rootFile prettierConfigs;
          require_cwd = true;
        };
      };

      formatters_by_ft =
        lib.genAttrs [
          "javascript"
          "json"
          "jsonc"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ] (_: {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "prettier";
          stop_after_first = true;
        });
    };
  };
}
