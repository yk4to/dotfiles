{
  inputs,
  system,
  lib,
  ...
}: let
  herdr = inputs.llm-agents.packages.${system}.herdr;
in {
  home.packages = with inputs.llm-agents.packages.${system}; [
    codex
    claude-code
    herdr
  ];

  home.activation.herdrIntegrations = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${herdr}/bin/herdr integration install claude || true
    run ${herdr}/bin/herdr integration install codex || true
  '';
}
