{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;

    accent = "blue";
    flavor = "mocha";

    cache.enable = true;

    tty.enable = false;
    plymouth.enable = false;
  };
}
