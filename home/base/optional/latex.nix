{
  pkgs,
  inputs,
  config,
  lib,
  system,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.latex;
  # LuaLaTeX reports: Japanese text, figures, tables, and hyperlinks.
  reportTex = pkgs.texliveBasic.withPackages (ps:
    with ps; [
      luatex
      luatexja
      haranoaji
      lm
      latexmk
      latexindent
      geometry
      graphics
      booktabs
      tools
      float
      hyperref
      luacode
      # Engineering reports: equations, PDF covers, tables, and diagrams.
      amsmath
      amsfonts
      pdfpages
      pdflscape
      multirow
      caption
      enumitem
      pgf
      babel-japanese
      # LuaTeX-ja's runtime requirements seen in the report build logs.
      xkeyval
      etoolbox
      everyhook
      svn-prov
      jsclasses
    ]);
in {
  options.optionalModules.base.latex = {
    enable = mkEnableOption "LaTeX (TeX Live)";

    package = mkOption {
      type = types.package;
      default = reportTex;
      defaultText = literalExpression "pkgs.texliveBasic.withPackages (ps: with ps; [ luatex luatexja haranoaji lm latexmk latexindent geometry graphics booktabs tools float hyperref luacode amsmath amsfonts pdfpages pdflscape multirow caption enumitem pgf babel-japanese xkeyval etoolbox everyhook svn-prov jsclasses ])";
      description = "TeX environment for Japanese LuaLaTeX reports";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.vscode.profiles.default = {
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace-release;
      with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        james-yu.latex-workshop # latex support
      ];

      userSettings = {
        "latex-workshop.intellisense.package.enabled" = true;
        "latex-workshop.view.pdf.viewer" = "tab";
        "latex-workshop.latex.outDir" = "out";
        "latex-workshop.latex.recipe.default" = "latexmk (lualatex)";
        "latex-workshop.formatting.latex" = "latexindent";
      };
    };
  };
}
