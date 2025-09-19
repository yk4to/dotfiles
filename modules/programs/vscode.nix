{
  delib,
  pkgs,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.vscode";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = let
    inherit (pkgs.stdenv) isDarwin;

    # ref: https://github.com/nix-community/nix-vscode-extensions/issues/99#issuecomment-2701520457
    # use overlay to allow unfree packages
    pkgs-ext = import inputs.nixpkgs {
      inherit (pkgs) system;
      config.allowUnfree = true;
      overlays = [inputs.nix-vscode-extensions.overlays.default];
    };
  in {
    programs.vscode = {
      enable = true;

      # on macOS, use a mock package to install vscode from brew instead of nix
      package =
        if isDarwin
        then
          (pkgs.writeShellScriptBin "vscode-mock" "true").overrideAttrs (oldAttrs: {
            pname = "vscode";
            version = "999";
          })
        else pkgs.vscode;

      profiles.default = {
        # disable auto update on linux(NixOS)
        enableUpdateCheck = isDarwin;

        # NOTE: Extensions installed without Nix must be updated manually
        # because extension update check is set to disabled
        enableExtensionUpdateCheck = false;

        extensions = with pkgs-ext.vscode-marketplace-release;
        with pkgs-ext.vscode-marketplace; [
          # General
          ms-ceintl.vscode-language-pack-ja # japanese language pack

          # Themes
          zhuangtongfa.material-theme # Atom One Dark Theme
          pkief.material-icon-theme # material icons

          # AI
          github.copilot-chat # GitHub Copilot Chat
          github.copilot # GitHub Copilot
          # openai.chatgpt # ChatGPT

          # Git / GitHub
          # github.vscode-pull-request-github # github pull requests
          # github.vscode-github-actions # github actions
          eamodio.gitlens # gitlens

          # Containers
          ms-vscode-remote.remote-containers # remote containers
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

          "editor.inlayHints.enabled" = "offUnlessPressed";

          "terminal.integrated.fontFamily" = "'UDEV Gothic 35NF'";
          "terminal.integrated.fontSize" = 13;
          "terminal.integrated.cursorStyle" = "line";

          "workbench.startupEditor" = "none"; # disable welcome page
          "workbench.editor.empty.hint" = "hidden";
          "workbench.colorTheme" = "One Dark Pro";
          "workbench.iconTheme" = "material-icon-theme";

          "window.commandCenter" = false; # disable command center on title bar

          "git.confirmSync" = false;
          "git.autofetch" = true;
          "git.openRepositoryInParentFolders" = "never";

          "extensions.ignoreRecommendations" = true;

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
    };

    home.file.".vscode/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      locale = "ja";
    };
  };
}
