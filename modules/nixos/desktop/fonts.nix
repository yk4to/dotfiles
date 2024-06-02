{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # system fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      # other fonts
      udev-gothic
      udev-gothic-nf
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
