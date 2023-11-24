return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        silent_chdir = false,
        show_hidden = true,
        detection_methods = { "pattern" },
      })
    end,
  },
}
