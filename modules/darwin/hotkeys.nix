# ref: https://gist.github.com/jimratliff/227088cc936065598bedfd91c360334e
let
  disabledKeys = [
    # Spotlight
    # Disable 'Cmd + Space' for Spotlight Search
    64
    # Disable 'Cmd + Alt + Space' for Finder search window
    65

    # Screenshot
    28
    29
    30
    31
    184
  ];

  enabledKeys = [
    # Window Management
    # Full screen: Ctrl + Option + Enter
    {
      key = 237;
      parameters = [65535 36 786432];
    }
    # Ctrl + Option + C
    {
      key = 238;
      parameters = [99 8 786432];
    }
    # Ctrl + Option + ←
    {
      key = 240;
      parameters = [65535 123 11272192];
    }
    # Ctrl + Option + →
    {
      key = 241;
      parameters = [65535 124 11272192];
    }
    # Ctrl + Option + ↑
    {
      key = 242;
      parameters = [65535 126 11272192];
    }
    # Ctrl + Option + ↓
    {
      key = 243;
      parameters = [65535 125 11272192];
    }
    # Ctrl + Option + U
    {
      key = 244;
      parameters = [117 32 786432];
    }
    # Ctrl + Option + I
    {
      key = 245;
      parameters = [105 34 786432];
    }
    # Ctrl + Option + J
    {
      key = 246;
      parameters = [106 38 786432];
    }
    # Ctrl + Option + K
    {
      key = 247;
      parameters = [107 40 786432];
    }
  ];

  disabledAttrs = builtins.listToAttrs (map (key: {
      name = toString key;
      value = {enabled = false;};
    })
    disabledKeys);

  enabledAttrs = builtins.listToAttrs (map (x: {
      name = toString x.key;
      value = {
        enabled = true;
        value = {
          parameters = x.parameters;
          type = "standard";
        };
      };
    })
    enabledKeys);
in {
  system.defaults.CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys =
    disabledAttrs // enabledAttrs;
}
