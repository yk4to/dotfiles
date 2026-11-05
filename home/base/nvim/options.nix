{
  programs.nixvim = {
    globals.mapleader = " ";

    opts = {
      number = true;
      clipboard = "unnamedplus";
      termguicolors = true;
      cursorline = true;
      mouse = "a";

      ignorecase = true;
      smartcase = true;

      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      softtabstop = 2;
      tabstop = 2;

      splitbelow = true;
      splitright = true;
      signcolumn = "yes";
      scrolloff = 8;
      timeoutlen = 300;
      updatetime = 250;
      undofile = true;

      completeopt = "menu,menuone,noselect";
      foldlevel = 99;
      foldlevelstart = 99;
    };
  };
}
