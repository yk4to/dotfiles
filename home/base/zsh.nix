{
  isDarwin,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
      highlight = "fg=8";
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "^[[A"
        "^P"
      ];
      searchDownKey = [
        "^[[B"
        "^N"
      ];
    };
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-abbr";
        src = pkgs.zsh-abbr.src;
        file = "zsh-abbr.plugin.zsh";
      }
    ];

    initContent = ''
      ${
        lib.optionalString isDarwin ''
          # homebrew (only on darwin)
          path=(/opt/homebrew/bin $path)
        ''
      }

      setopt AUTO_CD
      setopt COMPLETE_IN_WORD

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list \
        'm:{a-z}={A-Za-z}' \
        '+r:|[._-]=* r:|=*' \
        'l:|=* r:|=*'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' squeeze-slashes true
      zstyle ':completion:*:descriptions' format '%F{blue}[%d]%f'
      zstyle ':completion:*:warnings' format '%F{yellow}no matches for:%f %d'

      abbr add --quiet --session --force ll='eza --icons -al'
      abbr add --quiet --session --force nn='nvim'
      abbr add --quiet --session --force g='git'
      abbr add --quiet --session --force cl='clear'
      abbr add --quiet --session --force to='touch'
      abbr add --quiet --session --force tr='trash'
      abbr add --quiet --session --force ff='fastfetch'

      if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh --no-cmd)"
      fi

      if command -v direnv >/dev/null 2>&1; then
        eval "$(direnv hook zsh)"
      fi

      __zoxide_list_missing() {
        if ! command -v ghq >/dev/null 2>&1; then
          return 0
        fi

        diff \
          <(zoxide query --list | sort) \
          <(ghq list -p | sort) \
          | sed -n 's/^> //p'
      }

      __zoxide_add_missing() {
        local missing
        missing="$(__zoxide_list_missing)"

        if [ -n "$missing" ]; then
          while IFS= read -r path; do
            [ -n "$path" ] && zoxide add "$path"
          done <<< "$missing"
        fi
      }

      zi() {
        __zoxide_add_missing
        __zoxide_zi "$@" || true
      }
    '';
  };
}
