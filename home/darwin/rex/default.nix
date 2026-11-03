{
  config,
  lib,
  pkgs,
  ...
}: let
  # Rex Beta is distributed outside Homebrew; the app keeps the server and the CLI here.
  rex = "${config.home.homeDirectory}/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex";
  rexSocket = "${config.home.homeDirectory}/Library/Application Support/rex/server.sock";

  codexPermissions = pkgs.writers.writePython3 "rex-codex-permissions" {
    libraries = [pkgs.python3Packages.tomlkit];
    flakeIgnore = ["E501"];
  } (builtins.readFile ./codex-permissions.py);

  themeFile = "catppuccin-${config.catppuccin.flavor}.conf";
in {
  # App settings live in user defaults rather than init.lua.
  targets.darwin.defaults."com.superlogical.rex" = {
    "Workspace.appearance" = "dark";
    "Workspace.interfaceStyle" = "blendTheme";
    "Workspace.usesPaneGlass" = true;

    # Match Ghostty. Rex lists only monospaced families, hence the Mono variant.
    "Workspace.terminalFontName" = "JetBrainsMono Nerd Font Mono";
    "Workspace.terminalFallbackFontNames" = ["UDEV Gothic 35LG"];
    "Workspace.terminalFontPointSize" = config.optionalModules.base.ghostty.fontSizeInPt;
    "Workspace.terminalFontSmoothing" = true;
    "Workspace.terminalCursorStyle" = "bar";

    # Let the CLI perform app actions, such as importing the theme below.
    "rex.client.remoteControl" = true;
  };

  # Rex has no Catppuccin built in, but it can import Ghostty themes.
  xdg.configFile."rex/themes/${themeFile}" = {
    source = "${config.catppuccin.sources.ghostty}/${themeFile}";
    # Importing selects the theme; it needs Remote Control turned on in the app's settings.
    onChange = ''
      if [ -x "${rex}" ]; then
        run "${rex}" --autostart=false do client.theme.import path="${config.xdg.configHome}/rex/themes/${themeFile}" || true
      fi
    '';
  };

  xdg.configFile."rex/init.lua" = {
    source = ./init.lua;
    # Rex does not watch the file; reload a running server without starting a new one.
    onChange = ''
      if [ -x "${rex}" ]; then
        run "${rex}" --autostart=false config reload || true
      fi
    '';
  };

  # Rex prepends REX_BIN_DIR to PATH, but nix-darwin resets PATH on shell start.
  # ref: https://www.superlogical.com/rex/docs/automate/cli#nix
  programs.zsh.initContent = lib.mkAfter ''
    if [ -n "$REX_BIN_DIR" ]; then
      export PATH="$REX_BIN_DIR:$PATH"
    fi
  '';

  # Guard written by `rex terminfo setup`: fall back to xterm-256color on hosts without xterm-rex.
  programs.ssh.includes = ["~/.config/rex/ssh_config"];

  home.activation.rexIntegrations = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -x "${rex}" ]; then
      run "${rex}" terminfo setup || true
      run "${rex}" skill setup || true
    fi
  '';

  # Codex's sandbox blocks the Rex socket, so `rex` fails inside Codex without this profile.
  home.activation.rexCodexPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -d "${config.home.homeDirectory}/.codex" ]; then
      run ${codexPermissions} "${config.home.homeDirectory}/.codex/config.toml" "${rexSocket}" || true
    fi
  '';
}
