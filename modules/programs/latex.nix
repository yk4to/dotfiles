{
  delib,
  pkgs,
  lib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.latex";

  options = delib.singleEnableOption host.academicFeatured;

  home.ifEnabled = {myconfig, ...}: let
    inherit (host) system;
    vscodeEnabled = myconfig.programs.vscode.enable;
  in {
    # FIXME: texliveFull is too big
    home.packages = [pkgs.texliveFull];

    programs.vscode.profiles.default = lib.optional vscodeEnabled {
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace-release;
      with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        james-yu.latex-workshop # latex support
      ];

      userSettings = {
        "latex-workshop.intellisense.package.enabled" = true;
        "latex-workshop.view.pdf.viewer" = "tab";
        "latex-workshop.latex.outDir" = "out";
        "latex-workshop.latex.recipe.default" = "latexmk (lualatex)";
      };
    };
  };
}
