{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.zsh";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    environment = {
      shells = [pkgs.zsh];
      systemPackages = [pkgs.zsh];
    };

    programs.zsh.enable = true;
  };
}
