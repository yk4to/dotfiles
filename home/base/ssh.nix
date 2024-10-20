{pkgs, ...}: let
  includeConfig =
    if pkgs.stdenv.isDarwin
    then ["~/.orbstack/ssh/config"]
    else [];
in {
  programs.ssh = {
    enable = true;

    includes = includeConfig;
  };
}
