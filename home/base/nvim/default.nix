{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    wrapRc = true;
    defaultEditor = true;

    # TODO: remove this line when this issue is resolved:
    # https://github.com/nix-community/nixvim/issues/4408#issuecomment-4699739928
    nixpkgs.useGlobalPackages = true;
  };
}
