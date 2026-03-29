{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;

    accent = "blue";
    flavor = "mocha";

    cache.enable = true;

    cursors = {
      enable = true;
      accent = "blue";
    };
  };
}
