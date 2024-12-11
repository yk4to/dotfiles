{
  pkgs,
  inputs,
  config,
  lib,
  system,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.vscode;
  # disable auto update on linux(NixOS)
  updateMode =
    if pkgs.stdenv.isLinux
    then "none"
    else "manual";
in {
  options.optionalModules.base.vscode = {
    enable = mkEnableOption "Visual Studio Code";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace-release;
      with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        # General
        ms-ceintl.vscode-language-pack-ja # japanese language pack

        # Themes
        zhuangtongfa.material-theme # Atom One Dark Theme
        pkief.material-icon-theme # material icons

        # AI
        # Get `copilot-chat` from nixpkgs
        # ref: https://github.com/nix-community/nix-vscode-extensions/issues/76
        pkgs.vscode-extensions.github.copilot-chat # github copilot chat
        github.copilot # github copilot

        # Git / GitHub
        # github.vscode-pull-request-github # github pull requests
        # github.vscode-github-actions # github actions
        eamodio.gitlens # gitlens

        # Containers
        # ms-vscode-remote.remote-containers # remote containers
        # ms-azuretools.vscode-docker # docker support

        # Nix
        jnoortheen.nix-ide # nix support
        # kamadorueda.alejandra # alejandra (nix formatter) support

        # Language Support
        # idleberg.applescript # applescript support
        # ms-vscode.cpptools # C/C++ support
        # denoland.vscode-deno # deno support
        # tamasfe.even-better-toml # toml support
        # skyapps.fish-vscode # fish support
        mechatroner.rainbow-csv # csv support
        # mariomatheu.syntax-project-pbxproj # Xcode syntax support
        # mhcpnl.xcodestrings # Xcode strings support
        # coolbear.systemd-unit-file # systemd unit file support
        rowewilsonfrederiskholme.wikitext # wiki syntax support

        # Markdown
        yzhang.markdown-all-in-one # markdown support
        bierner.markdown-emoji # add emoji syntax support
        bierner.markdown-preview-github-styles # github markdown styles

        # Utilities
        naumovs.color-highlight # highlight colors
        anseki.vscode-color # color picker
        simonsiefke.svg-preview # preview svg files
        oderwat.indent-rainbow # make indentation more readable
        usernamehw.errorlens # highlight the entire line

        # Web Development
        ms-vscode.live-server # host a local server
        dbaeumer.vscode-eslint # eslint support
        esbenp.prettier-vscode # prettier support
        stylelint.vscode-stylelint # stylelint support
        yoavbls.pretty-ts-errors # make typescript errors pretty
        formulahendry.auto-rename-tag # rename tags
        vunguyentuan.vscode-css-variables # autocomplete css variables
        bradgashler.htmltagwrap # wrap html tags

        # Others
        # platformio.platformio-ide
      ];

      userSettings = {
        "editor.fontFamily" = "'UDEV Gothic 35NF', Menlo, Monaco, 'Courier New', monospace";
        "editor.fontSize" = 14;
        "editor.inlineSuggest.enabled" = true;
        "editor.tabSize" = 2;

        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;

        "terminal.integrated.fontFamily" = "'UDEV Gothic 35NF'";
        "terminal.integrated.fontSize" = 13;

        "workbench.startupEditor" = "none"; # disable welcome page
        "workbench.editor.empty.hint" = false;
        "workbench.colorTheme" = "One Dark Pro";
        "workbench.iconTheme" = "material-icon-theme";

        "window.commandCenter" = false; # disable command center on title bar

        "git.confirmSync" = false;
        "git.autofetch" = true;
        "git.openRepositoryInParentFolders" = "never";

        "update.mode" = updateMode;

        # Extensions
        "wikitext.host" = "ja.wikipedia.org";
        # "platformio-ide.useBuiltinPIOCore" = false;

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
    };

    home.file.".vscode/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      locale = "ja";
    };
  };
}
