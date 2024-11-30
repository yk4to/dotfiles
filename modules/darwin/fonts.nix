{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      udev-gothic
      udev-gothic-nf

      nerd-fonts.jetbrains-mono
    ];
  };
}
