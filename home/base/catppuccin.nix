{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;

    accent = "blue";
    flavor = "mocha";

    cache.enable = true;
  };
}
