{pkgs, ...}: {
  home.packages = with pkgs; [
    commitizen
  ];

  programs.git = {
    enable = true;

    userName = "Yuta Kato";
    userEmail = "64204135+yk4to@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";

      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.program =
          if pkgs.stdenv.isDarwin
          then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
          else "${pkgs._1password-gui}/share/1password/op-ssh-sign";
      };
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKyEcrKmm/9CLZSzfaEqQ6VFjgXemIFpcdpIwrg1PYVy";
      signByDefault = true;
    };
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

      customCommands = [
        {
          key = "C";
          command = "git cz c";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool";
          subprocess = true;
        }
      ];
    };
  };
}
