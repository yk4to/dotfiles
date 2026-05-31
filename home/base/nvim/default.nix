{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    wrapRc = true;
  };
  # programs.nixvim.defaultEditor = true;
}
