{
  config,
  pkgs,
  lib,
  isDarwin,
  ...
}:
with lib; let
  cfg = config.optionalModules.darwin.inkdrop;

  dataDir = "${config.home.homeDirectory}/Library/Application Support/inkdrop";

  inkdropConfig = {
    "*" = {
      core = {
        betaChannel = true;
        devMode = true;
        themes = [
          "github-preview"
          "atom-one-dark-mod-syntax"
          "default-dark-ui"
        ];
      };
      editor = {
        fontFamily = "'UDEV Gothic 35NF',SFMono-Regular,Consolas,Liberation Mono,Menlo,Courier,monospace";
      };
      "thumbnail-list" = {
        showEmoji = true;
      };
    };
  };

  inkdropPlugins = [
    "atom-one-dark-mod-syntax"
    "emoji-picker"
    "thumbnail-list"
    "img-small"
  ];

  patchJson = builtins.toFile "inkdrop-config.json" (builtins.toJSON inkdropConfig);
in {
  options.optionalModules.darwin.inkdrop = {
    enable = mkEnableOption "Inkdrop";
  };

  config = mkIf (cfg.enable && isDarwin) {
    home.activation.inkdropSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # === Patch config.json ===
      CONFIG_PATH="${dataDir}/config.json"
      TMP_RESULT="$(mktemp)"

      # Ensure the config directory exists
      mkdir -p "$(dirname "$CONFIG_PATH")"

      if [ -f "$CONFIG_PATH" ]; then
        ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "$CONFIG_PATH" "${patchJson}" > "$TMP_RESULT" && mv "$TMP_RESULT" "$CONFIG_PATH"
      else
        cp --no-preserve=mode,ownership "${patchJson}" "$CONFIG_PATH"
      fi

      # === Install plugins ===
      REQUIRED_PLUGINS=(${lib.concatStringsSep " " inkdropPlugins})

      # Find the correct ipm command
      if command -v ipm >/dev/null 2>&1; then
        IPM=ipm
      elif command -v ipm-beta >/dev/null 2>&1; then
        IPM=ipm-beta
      elif [ -x /usr/local/bin/ipm ]; then
        IPM=/usr/local/bin/ipm
      elif [ -x /usr/local/bin/ipm-beta ]; then
        IPM=/usr/local/bin/ipm-beta
      else
        echo "Error: Neither ipm nor ipm-beta was found in PATH or /usr/local/bin."
        exit 1
      fi

      echo "Using $IPM as the ipm command."

      # Get currently installed plugins
      INSTALLED_PLUGINS=$($IPM list --bare | cut -d'@' -f1)

      # Determine missing plugins
      PLUGINS_TO_INSTALL=()
      for plugin in "''${REQUIRED_PLUGINS[@]}"; do
        if ! echo "$INSTALLED_PLUGINS" | grep -q "^$plugin$"; then
          PLUGINS_TO_INSTALL+=("$plugin")
        fi
      done

      # Determine redundant plugins
      PLUGINS_TO_UNINSTALL=()
      for plugin in $INSTALLED_PLUGINS; do
        if ! [[ " ''${REQUIRED_PLUGINS[@]} " =~ " $plugin " ]]; then
          PLUGINS_TO_UNINSTALL+=("$plugin")
        fi
      done

      # Install missing plugins
      if [ "''${#PLUGINS_TO_INSTALL[@]}" -gt 0 ]; then
        echo "Installing plugins: ''${PLUGINS_TO_INSTALL[@]}"
        $IPM install "''${PLUGINS_TO_INSTALL[@]}"
      else
        echo "All required plugins are already installed."
      fi

      # Uninstall redundant plugins
      if [ "''${#PLUGINS_TO_UNINSTALL[@]}" -gt 0 ]; then
        echo "Uninstalling plugins: ''${PLUGINS_TO_UNINSTALL[@]}"
        $IPM uninstall "''${PLUGINS_TO_UNINSTALL[@]}"
      else
        echo "No redundant plugins to uninstall."
      fi
    '';
  };
}
