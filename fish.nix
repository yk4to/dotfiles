{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # disable greeting
      set -g fish_greeting
      # starship
      source ~/dotfiles/fish/starship_async_transient_prompt.fish
    '';
  };
}