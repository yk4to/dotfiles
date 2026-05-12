{
  inputs,
  system,
  ...
}: {
  home.packages = with inputs.llm-agents.packages.${system}; [
    codex
  ];
}
