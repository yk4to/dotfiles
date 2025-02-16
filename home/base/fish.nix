{isDarwin, ...}: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ll = "eza --icons -al";
      nn = "nvim";
      lg = "lazygit";
      g = "git";
      cl = "clear";
      to = "touch";
      tr = "trash";
      ff = "fastfetch";
    };

    interactiveShellInit = ''
      # disable greeting
      set -g fish_greeting

      # make the completion not be the same color as the bg color
      set -g fish_color_autosuggestion 5c6370

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
          type -q zoxide && zoxide init fish >>$CONFIG_CACHE
          direnv hook fish >>$CONFIG_CACHE

          set_color brmagenta --bold --underline
          echo "cache updated"
          set_color normal
      end
      source $CONFIG_CACHE
    '';
  };
}
