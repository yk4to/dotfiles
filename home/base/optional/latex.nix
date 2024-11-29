{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.base.latex;
in {
  options.modules.base.latex = {
    enable = mkEnableOption "LaTeX (TeX Live)";

    package = mkOption {
      type = types.package;
      default = pkgs.texliveFull;
      defaultText = literalExpression "pkgs.texliveFull";
      description = "Tex package to install";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.vscode = {
      extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release;
      with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
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
