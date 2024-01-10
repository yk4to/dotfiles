set -g FISH_CONFIG_DIR $HOME/.config/fish
set -g FISH_CONFIG $FISH_CONFIG_DIR/config.fish
set -g FISH_CACHE_DIR $HOME/.cache/fish

# aliases
alias vim="nvim"

# abbrs
abbr --add ll "eza --icons -al"
abbr --add nn nvim
abbr --add lg lazygit
abbr --add g git
abbr --add cl clear
abbr --add to touch
abbr --add tr trash
abbr --add ne neofetch
abbr --add bb "brew upgrade && brew update"
abbr --add agi add-gitignore

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# starship
source $FISH_CONFIG_DIR/starship_async_transient_prompt.fish

# iterm2
# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
# source ~/.iterm2_shell_integration.fish

# deno
set -x DENO_INSTALL $HOME/.deno
set -x PATH $DENO_INSTALL/bin:$PATH

# cache
# ref: https://zenn.dev/ryoppippi/articles/de6c931cc1028f
set -l CONFIG_CACHE $FISH_CACHE_DIR/config.fish
if test "$FISH_CONFIG" -nt "$CONFIG_CACHE"
    mkdir -p $FISH_CACHE_DIR
    echo '' >$CONFIG_CACHE

    # tools
    type -q mise && mise activate fish >>$CONFIG_CACHE
    type -q zoxide && zoxide init fish >>$CONFIG_CACHE

    set_color brmagenta --bold --underline
    echo "cache updated"
    set_color normal
end
source $CONFIG_CACHE
