{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      udev-gothic
      udev-gothic-nf

      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };
}
