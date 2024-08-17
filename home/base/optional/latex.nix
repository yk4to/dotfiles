{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    texliveFull
  ];

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
}
