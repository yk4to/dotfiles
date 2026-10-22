{
  pkgs,
  vars,
  ...
}: {
  home.packages = with pkgs; [
    koji # conventional commit prompt
    ghq
  ];

  # Layered on top of koji's defaults, so the default commit types are kept
  xdg.configFile."koji/config.toml".source = (pkgs.formats.toml {}).generate "koji-config.toml" {
    # Suggest scopes from the commit history
    autocomplete = true;
  };

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
        # Conventional commit via koji, committed by git itself so that hooks run
        # (koji commits via libgit2). Extra args are passed to `git commit`.
        cz = ''!f() { git commit -m "$(koji --stdout)" "$@"; }; f'';
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
  };

  # git TUI
  programs.lazygit = {
    enable = true;

    shellWrapperName = "gg";

    settings = {
      git.diffRenderers = [
        {
          command = "delta --paging=never";
        }
      ];

      gui.nerdFontsVersion = "3";

      disableStartupPopups = true;
      notARepository = "quit";

      customCommands = [
        {
          key = "C";
          command = "git cz";
          description = "commit with koji";
          context = "files";
          loadingText = "opening koji commit tool";
          output = "terminal";
        }
      ];
    };
  };
}
