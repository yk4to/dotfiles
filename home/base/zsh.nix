{
  config,
  isDarwin,
  lib,
  pkgs,
  ...
}: let
  regularAbbreviations = {
    cl = "clear";
    ff = "fastfetch";
    g = "git";
    ll = "eza --icons -al";
    nn = "nvim";
    to = "touch";
    tr = "trash";
  };

  escapeZshRegexp = value:
    lib.replaceStrings
    [
      "\\"
      "."
      "+"
      "*"
      "?"
      "("
      ")"
      "["
      "]"
      "{"
      "}"
      "^"
      "$"
      "|"
    ]
    [
      "\\\\"
      "\\."
      "\\+"
      "\\*"
      "\\?"
      "\\("
      "\\)"
      "\\["
      "\\]"
      "\\{"
      "\\}"
      "\\^"
      "\\$"
      "\\|"
    ]
    value;

  regularAbbreviationRegexp = lib.concatStringsSep "|" (
    map escapeZshRegexp (builtins.attrNames regularAbbreviations)
  );

  commandHighlightStyle = "fg=${config.catppuccin.accent}";

  zshAbbrCompiled = pkgs.runCommand "zsh-abbr-compiled" {
    nativeBuildInputs = [pkgs.zsh];
  } ''
    cp -R ${pkgs.zsh-abbr.src}/. "$out"
    chmod -R u+w "$out"

    zsh -fc 'zcompile "$1"' _ "$out/zsh-abbr.zsh"
    zsh -fc 'zcompile "$1"' _ "$out/zsh-job-queue/zsh-job-queue.zsh"
  '';

  zshStaticHooks =
    pkgs.runCommand "zsh-static-hooks" {
      nativeBuildInputs = [
        pkgs.atuin
        pkgs.direnv
        pkgs.zoxide
      ];
    } ''
      mkdir -p "$out"
      HOME="$TMPDIR/atuin-home" XDG_CONFIG_HOME="$TMPDIR/atuin-home/.config" ATUIN_TMUX_POPUP=false atuin init zsh > "$out/atuin.zsh"
      zoxide init zsh --no-cmd > "$out/zoxide.zsh"
      direnv hook zsh > "$out/direnv.zsh"
    '';
in {
  xdg.configFile."zsh-abbr/user-abbreviations".text = ''
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: value: "abbr ${lib.escapeShellArg name}=${lib.escapeShellArg value}"
      )
      regularAbbreviations
    )}
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    profileExtra = lib.optionalString isDarwin ''
      # OrbStack command-line tools and integration
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :
    '';
    completionInit = lib.mkBefore ''
      () {
        emulate -L zsh
        zmodload zsh/datetime
        zmodload zsh/stat
        autoload -U compinit

        local dumpfile="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
        local -a dumpstat
        local regenerate=1

        mkdir -p "''${dumpfile:h}"

        if [[ -s "$dumpfile" && -s "$dumpfile.zwc" ]]; then
          zstat -A dumpstat +mtime -- "$dumpfile" 2>/dev/null || true

          if (( ''${#dumpstat} && EPOCHSECONDS - dumpstat[1] < 86400 )); then
            regenerate=0
          fi
        fi

        if (( regenerate )); then
          compinit -d "$dumpfile"

          if [[ ! -s "$dumpfile.zwc" || "$dumpfile" -nt "$dumpfile.zwc" ]]; then
            zcompile "$dumpfile"
          fi
        else
          compinit -C -d "$dumpfile"
        fi
      }
    '';
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
        "^P"
      ];
      searchDownKey = [
        "^N"
      ];
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = lib.mkForce [
        "main"
        "regexp"
      ];
    };

    plugins = [
      {
        name = "zsh-abbr";
        src = zshAbbrCompiled;
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

      # Treat Home Manager abbreviations as commands for syntax highlighting.
      typeset -gA ZSH_HIGHLIGHT_REGEXP
      __zsh_abbr_highlight_regexp="^[[:blank:][:space:]]*(${regularAbbreviationRegexp})$"
      ZSH_HIGHLIGHT_REGEXP[$__zsh_abbr_highlight_regexp]="${commandHighlightStyle}"
      unset __zsh_abbr_highlight_regexp

      for __zsh_command_style in alias builtin command function global-alias hashed-command precommand reserved-word suffix-alias; do
        ZSH_HIGHLIGHT_STYLES[$__zsh_command_style]="${commandHighlightStyle}"
      done
      unset __zsh_command_style

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

      source ${zshStaticHooks}/zoxide.zsh
      ${lib.optionalString config.programs.direnv.enable ''
        source ${zshStaticHooks}/direnv.zsh
      ''}
      ${lib.optionalString config.programs.atuin.enable ''
        source ${zshStaticHooks}/atuin.zsh
      ''}

      __zoxide_list_missing() {
        if ! command -v ghq >/dev/null 2>&1; then
          return 0
        fi

        comm -13 <(zoxide query --list | sort) <(ghq list -p | sort)
      }

      __zoxide_add_missing() {
        local -a missing
        missing=("''${(@f)$(__zoxide_list_missing)}")

        if (( ''${#missing[@]} )) && [[ -n "''${missing[1]}" ]]; then
          zoxide add "''${missing[@]}"
        fi
      }

      z() {
        __zoxide_z "$@"
      }

      zi() {
        __zoxide_add_missing
        __zoxide_zi "$@" || true
      }
    '';
  };
}
