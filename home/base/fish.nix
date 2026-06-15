{
  isDarwin,
  pkgs,
  ...
}: let
  zoxideGhqFunctions = pkgs.writeText "fish-zoxide-ghq.fish" ''
    function z
        __zoxide_z $argv
    end

    function __zoxide_list_missing
        if ! type -q ghq
            return 0
        end

        diff \
            (zoxide query --list | sort | psub) \
            (ghq list -p | sort | psub) \
            | string match --regex --entire "^> " \
            | string replace -r "^> " ""
    end

    function __zoxide_add_missing
        set -l missing (__zoxide_list_missing)
        if test (count $missing) -gt 0
            zoxide add $missing
        end
    end

    function zi --description "zoxide with ghq"
        __zoxide_add_missing
        __zoxide_zi $argv || true
    end
  '';
in {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ll = "eza --icons -al";
      nn = "nvim";
      g = "git";
      cl = "clear";
      to = "touch";
      tr = "trash";
      ff = "fastfetch";
    };

    interactiveShellInit = ''
      # disable greeting
      set -g fish_greeting

      ${
        if isDarwin
        then ''
          # homebrew (only on darwin)
          set -gx PATH \"/opt/homebrew/bin\" $PATH''
        else ""
      }

      # cache
      # ref: https://zenn.dev/ryoppippi/articles/de6c931cc1028f
      set -l CONFIG_CACHE $HOME/.cache/fish/config.fish
      if test "$HOME/.config/fish/config.fish" -nt "$CONFIG_CACHE"
          mkdir -p $HOME/.cache/fish
          echo "" >$CONFIG_CACHE

          # tools
          if type -q zoxide
              zoxide init fish --no-cmd >>$CONFIG_CACHE
              cat ${zoxideGhqFunctions} >>$CONFIG_CACHE
          end
          direnv hook fish >>$CONFIG_CACHE

          set_color brmagenta --bold --underline
          echo "cache updated"
          set_color normal
      end
      source $CONFIG_CACHE
    '';
  };
}
