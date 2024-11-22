{
  pkgs,
  inputs,
  mylib,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs; [
    discord
    slack
  ];
}
