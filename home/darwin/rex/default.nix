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

  # Move REX_BIN_DIR to the front without duplicating it.
  rexPath = ''
    if [[ -n "$REX_BIN_DIR" ]]; then
      path=("$REX_BIN_DIR" ''${path:#$REX_BIN_DIR})
    fi
  '';
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
  # Commands Rex starts directly (e.g. `rex split -- claude`) get a non-interactive login
  # shell's environment, so restore it in .zprofile too; .zshrc puts Homebrew in front later.
  # ref: https://www.superlogical.com/rex/docs/automate/cli#nix
  programs.zsh.profileExtra = lib.mkAfter rexPath;
  programs.zsh.initContent = lib.mkAfter rexPath;

  # Guard written by `rex terminfo setup`: fall back to xterm-256color on hosts without xterm-rex.
  programs.ssh.includes = ["~/.config/rex/ssh_config"];

  home.activation.rexIntegrations = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -x "${rex}" ]; then
      # Rex verifies the ssh guard with ssh, which is not on the activation PATH.
      run env PATH="$PATH:/usr/bin" "${rex}" terminfo setup || true
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
