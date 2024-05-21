{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "yk4to";
    userEmail = "64204135+yk4to@users.noreply.github.com";

    extraConfig = { init.defaultBranch = "main"; };
  };

  # GitHub CLI
  programs.gh.enable = true;

  # git diff viewer
  programs.git.delta = {
    enable = true;
    options.syntax-theme = "OneHalfDark";
  };

  # git TUI
  programs.lazygit = {
    enable = true;

    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --paging=never";
      };

      gui.nerdFontsVersion = "3";

      disableStartupPopups = true;
      notARepository = "quit";
    };
  };
}
