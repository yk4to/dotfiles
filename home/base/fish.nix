{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ll = "eza --icons -al";
      lg = "lazygit";
      g = "git";
      cl = "clear";
      to = "touch";
      tr = "trash";
      ne = "neofetch";
    };

    interactiveShellInit = ''
      # disable greeting
      set -g fish_greeting

      # starship
      ${builtins.readFile ../../fish/starship_async_transient_prompt.fish}

      # homebrew
      if test -d "/opt/homebrew"
        set -gx PATH "/opt/homebrew/bin" $PATH
      end

      # ghostty shell integration
      if test -n "$GHOSTTY_RESOURCES_DIR"
        builtin source "''$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end

      # cache
      # ref: https://zenn.dev/ryoppippi/articles/de6c931cc1028f
      set -l CONFIG_CACHE $HOME/.cache/fish/config.fish
      if test "$HOME/.config/fish/config.fish" -nt "$CONFIG_CACHE"
          mkdir -p $HOME/.cache/fish
          echo "" >$CONFIG_CACHE

          # tools
          type -q zoxide && zoxide init fish >>$CONFIG_CACHE

          set_color brmagenta --bold --underline
          echo "cache updated"
          set_color normal
      end
      source $CONFIG_CACHE
    '';
  };
}