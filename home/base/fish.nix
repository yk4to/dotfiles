{pkgs, ...}: {
  # install starship without `programs` to load it asynchronously
  home.packages = with pkgs; [
    starship
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # disable greeting
      set -g fish_greeting

      # starship
      source ~/dotfiles/fish/starship_async_transient_prompt.fish

      # ghostty shell integration
      if test -n "$GHOSTTY_RESOURCES_DIR"
        builtin source "''$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end
    '';
  };
}