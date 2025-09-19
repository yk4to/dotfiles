{
  delib,
  host,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.inkdrop";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {myconfig, ...}: {
    imports = [inputs.nix-inkdrop.homeModules.default];

    programs.inkdrop = {
      enable = true;
      package =
        if pkgs.stdenv.isDarwin
        then null
        else inputs.nix-inkdrop.packages.${host.system}.default;

      ipmPath =
        if pkgs.stdenv.isDarwin
        then "/usr/local/bin/ipm"
        else "${inputs.nix-inkdrop.packages.${host.system}.default}/bin/ipm";

      themes = {
        ui = "default-dark-ui";
        syntax = "atom-one-dark-mod-syntax";
      };

      plugins = [
        "emoji-picker"
        "thumbnail-list"
        "img-small"
      ];

      extraConfig = {
        "*" = {
          core = {
            betaChannel = true;
            devMode = true;
          };
          editor = {
            fontFamily = "'UDEV Gothic 35NF',SFMono-Regular,Consolas,Liberation Mono,Menlo,Courier,monospace";
          };
          "thumbnail-list" = {
            showEmoji = true;
          };
        };
      };
    };
  };
}
