{config, ...}: let
  helpers = config.lib.nixvim;
in {
  programs.nixvim.keymaps = [
    {
      key = "<Esc>";
      mode = "t";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
    {
      key = "gd";
      mode = "n";
      action = helpers.mkRaw "vim.lsp.buf.definition";
      options.desc = "Go to definition";
    }
    {
      key = "gr";
      mode = "n";
      action = "<cmd>lua Snacks.picker.lsp_references()<cr>";
      options.desc = "References";
    }
    {
      key = "K";
      mode = "n";
      action = helpers.mkRaw "vim.lsp.buf.hover";
      options.desc = "Hover";
    }
    {
      key = "<leader>ca";
      mode = ["n" "v"];
      action = helpers.mkRaw "vim.lsp.buf.code_action";
      options.desc = "Code action";
    }
    {
      key = "<leader>rn";
      mode = "n";
      action = helpers.mkRaw "vim.lsp.buf.rename";
      options.desc = "Rename symbol";
    }
    {
      key = "<leader>fd";
      mode = "n";
      action = helpers.mkRaw "vim.diagnostic.open_float";
      options.desc = "Line diagnostics";
    }
    {
      key = "[d";
      mode = "n";
      action = helpers.mkRaw "vim.diagnostic.goto_prev";
      options.desc = "Previous diagnostic";
    }
    {
      key = "]d";
      mode = "n";
      action = helpers.mkRaw "vim.diagnostic.goto_next";
      options.desc = "Next diagnostic";
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<cmd>bdelete<cr>";
      options.desc = "Close buffer";
    }
  ];
}
