{ pkgs, ... }: {
  fonts = {
    # will be removed after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    fontDir.enable = true;

    # will change to `fonts.packages` after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    fonts = with pkgs; [
      udev-gothic
      udev-gothic-nf

      # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}