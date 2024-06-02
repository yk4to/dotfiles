{pkgs, ...}: {
  # install vscode in this way instead of using `programs`
  # to use `sync settings`
  home.packages = with pkgs; [
    vscode
  ];

  # programs = {};
}
