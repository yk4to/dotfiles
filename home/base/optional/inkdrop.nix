{
  config,
  lib,
  isDarwin,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.inkdrop;
in {
  options.optionalModules.base.inkdrop = {
    enable = mkEnableOption "Inkdrop";
  };

  config = mkIf (cfg.enable) {
    programs.inkdrop = {
      enable = true;
      useCanary = true;

      package =
        if isDarwin
        then null
        else inputs.nix-inkdrop.packages.${system}.inkdrop-canary;

      themes = {
        ui = "default-dark-ui";
        syntax = "atom-one-dark-mod-syntax";
      };

      plugins = [
        "math"
        "sidetoc"
        # "emoji-picker"
        # "thumbnail-list"
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
