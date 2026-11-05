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
      key = "grr";
      mode = "n";
      action = "<cmd>lua Snacks.picker.lsp_references()<cr>";
      options.desc = "References";
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
      key = "<leader>bd";
      mode = "n";
      action = "<cmd>bdelete<cr>";
      options.desc = "Close buffer";
    }
  ];
}
