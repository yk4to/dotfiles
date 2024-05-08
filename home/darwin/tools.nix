{ pkgs, ... }: {
  home.packages = with pkgs; [
    darwin.trash
    mas
  ];
}