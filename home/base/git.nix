{
  pkgs,
  vars,
  ...
}: {
  home.packages = with pkgs; [
    commitizen
    ghq
  ];

  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      signByDefault = true;
    };

    settings = {
      user = {
        name = vars.userfullname;
        email = vars.useremail;
        signingkey = "~/.ssh/id_ed25519.pub";
      };

      alias = {
        main = "switch main";
      };

      init.defaultBranch = "main";
    };
  };

  # GitHub CLI
  programs.gh.enable = true;

  # git diff viewer
  programs.delta = {
    enable = true;

    enableGitIntegration = true;

    options.syntax-theme = "OneHalfDark";
  };

  # git TUI
  programs.lazygit = {
    enable = true;

    settings = {
      git.pagers = [
        {
          pager = "delta --paging=never";
        }
      ];

      gui.nerdFontsVersion = "3";

      disableStartupPopups = true;
      notARepository = "quit";

      customCommands = [
        {
          key = "C";
          command = "git cz c";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool";
          output = "terminal";
        }
      ];
    };
  };
}
