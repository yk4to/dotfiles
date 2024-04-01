{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "yk4to";
    userEmail = "64204135+yk4to@users.noreply.github.com";

    extraConfig = { init.defaultBranch = "main"; };
  };

  programs.gh.enable = true;

  programs.lazygit = {
    enable = true;

    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };

      gui.nerdFontsVersion = "3";

      disableStartupPopups = true;
      notARepository = "quit";
    };
  };
}
