return {
  {
    name = "nvim-lspconfig",
    dir = "@nvim_lspconfig@",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      for _, ls in pairs({
        "astro",
        "bashls",
        "biome",
        "nil_ls",
        "tsserver",
        "yamlls",
      }) do
        lspconfig[ls].setup({
          capabilities = capabilities,
        })
      end
      lspconfig.dockerls.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("Dockerfile", "Containerfile"),
      })
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          "docker-compose.yaml",
          "docker-compose.yml",
          "compose.yaml",
          "compose.yml"
        ),
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
  {
    name = "none-ls.nvim",
    dir = "@none_ls_nvim@",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.formatting.alejandra,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
        },
      })
    end,
  },
}