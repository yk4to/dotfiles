if status is-interactive
    # Commands to run in interactive sessions can go here
end

# aliases
alias ls='exa --icons'
alias g='git'
alias vim='nvim'
alias cl='clear'
alias dev='/bin/ls -d ~/dev/*/ | fzf --preview "onefetch  {} --show-logo never ; echo ; bat {}README.md" --bind "enter:become(code {})"'
alias agi='add-gitignore'

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# starship
source ~/dotfiles/starship_async_transient_prompt.fish

# iterm2
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
source ~/.iterm2_shell_integration.fish

# zoxide
zoxide init fish | source

# rtx
rtx activate fish | source

# deno
set -x DENO_INSTALL $HOME/.deno
set -x PATH $DENO_INSTALL/bin:$PATH
