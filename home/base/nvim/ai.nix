{
  programs.nixvim = {
    plugins.codecompanion = {
      enable = true;

      settings = {
        adapters = {
          acp.codex.__raw = ''
            function()
              return require("codecompanion.adapters").extend("codex", {
                defaults = {
                  auth_method = "chatgpt",
                },
              })
            end
          '';

          copilot = "copilot";
        };

        display.action_palette.provider = "snacks";

        interactions = {
          chat.adapter = "copilot";
          inline.adapter = "copilot";

          cli = {
            agent = "codex";
            agents.codex = {
              args = [];
              cmd = "codex";
              description = "OpenAI Codex CLI";
              provider = "terminal";
            };
          };
        };

        opts = {
          send_code = true;
          use_default_actions = true;
          use_default_prompts = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>aa";
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>CodeCompanionActions<cr>";
        options.desc = "AI actions";
      }
      {
        key = "<leader>ac";
        mode = "n";
        action = "<cmd>CodeCompanionChat Toggle<cr>";
        options.desc = "Copilot chat";
      }
      {
        key = "<leader>ai";
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>CodeCompanion<cr>";
        options.desc = "AI inline";
      }
      {
        key = "<leader>aC";
        mode = "n";
        action = "<cmd>CodeCompanionChat adapter=codex<cr>";
        options.desc = "Codex chat";
      }
      {
        key = "<leader>aA";
        mode = "n";
        action = "<cmd>CodeCompanionCLI agent=codex<cr>";
        options.desc = "Codex CLI";
      }
    ];
  };
}
