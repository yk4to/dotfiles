{
  # Home Manager owns completion and prompt initialization in home/base/zsh.nix.
  # Avoid repeating compinit and promptinit from /etc/zshrc on every shell start.
  programs.zsh = {
    enableGlobalCompInit = false;
    promptInit = "";
  };
}
