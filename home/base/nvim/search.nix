{
  programs.nixvim = {
    plugins.telescope.enable = true;

    keymaps = [
      {
        key = "<leader>ff";
        mode = "n";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Buffers";
      }
      {
        key = "<leader>fh";
        mode = "n";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help tags";
      }
    ];
  };
}
