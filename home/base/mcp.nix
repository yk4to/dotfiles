{
  inputs,
  isDarwin,
  system,
  lib,
  ...
}: let
  simplemoneyServer = {
    command = "/Applications/Simple Money.app/Contents/MacOS/simplemoney";
    args = ["mcp-server"];
  };
  codex = inputs.llm-agents.packages.${system}.codex;
in {
  imports = [inputs.mcp-servers-nix.homeManagerModules.default];

  # Shared MCP server registry (programs.mcp.servers), consumed by
  # individual programs via their enableMcpIntegration option.
  programs.mcp.enable = true;

  # Simple Money's MCP server is a macOS app binary, so only register it
  # when building for Darwin.
  mcp-servers.settings.servers = lib.optionalAttrs isDarwin {
    simplemoney = simplemoneyServer;
  };

  # Claude Code's MCP integration is delivered through an isolated
  # personal-plugin directory (~/.claude/skills/claude-code-home-manager),
  # so it's safe to manage declaratively without touching settings.json or
  # the claude-code package installed in home/base/llm.nix.
  programs.claude-code = {
    enable = true;
    package = null;
    enableMcpIntegration = true;
  };

  # Home Manager's programs.codex.enableMcpIntegration fully replaces
  # ~/.codex/config.toml with a read-only nix-store symlink, which would
  # wipe the runtime state the Codex app itself maintains there (trusted
  # projects, plugins, hooks). `codex mcp add` instead performs a surgical
  # upsert of just the [mcp_servers.<name>] table, leaving everything else
  # untouched, and is safe to re-run on every activation (verified: adding
  # the same server twice, or with changed args, just replaces its own
  # table without disturbing unrelated config.toml content).
  home.activation.codexMcpIntegration = lib.mkIf isDarwin (
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${codex}/bin/codex mcp add simplemoney -- ${lib.escapeShellArg simplemoneyServer.command} ${lib.concatMapStringsSep " " lib.escapeShellArg simplemoneyServer.args} || true
    ''
  );
}
