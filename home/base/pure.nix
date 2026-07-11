{
  lib,
  pkgs,
  ...
}: let
  pureCompiled = pkgs.runCommand "pure-prompt-compiled" {
    nativeBuildInputs = [pkgs.zsh];
  } ''
    cp -R ${pkgs.pure-prompt}/. "$out"
    chmod -R u+w "$out"

    zsh -fc 'zcompile "$1"' _ "$out/share/zsh/site-functions/async"
    zsh -fc 'zcompile "$1"' _ "$out/share/zsh/site-functions/prompt_pure_setup"
  '';
in {
  home.packages = [pureCompiled];

  # Load Pure after the other interactive integrations. This preserves the
  # initialization order validated by the Pure benchmark configuration.
  programs.zsh.initContent = lib.mkAfter ''
    fpath+=(${pureCompiled}/share/zsh/site-functions)
    source ${pureCompiled}/share/zsh/site-functions/prompt_pure_setup
  '';
}
