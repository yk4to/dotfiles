{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>ff";
        mode = "n";
        action = "<cmd>lua Snacks.picker.files()<cr>";
        options.desc = "Find files";
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "Live grep";
      }
      {
        key = "<leader>fp";
        mode = "n";
        action = "<cmd>lua Snacks.picker.projects()<cr>";
        options.desc = "Projects";
      }
      {
        key = "<leader>fr";
        mode = "n";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options.desc = "Recent files";
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        key = "<leader>fh";
        mode = "n";
        action = "<cmd>lua Snacks.picker.help()<cr>";
        options.desc = "Help tags";
      }
      {
        key = "<leader>sd";
        mode = "n";
        action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
        options.desc = "Diagnostics";
      }
      {
        key = "<leader>sD";
        mode = "n";
        action = "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>";
        options.desc = "Buffer diagnostics";
      }
    ];
  };
}
