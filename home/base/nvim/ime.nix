{
  isDarwin,
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      im-select-nvim
    ];

    extraConfigLua = ''
      require("im_select").setup({
        default_im_select = ${
        if isDarwin
        then "\"com.apple.keylayout.ABC\""
        else "\"keyboard-us\""
      },
        default_command = ${
        if isDarwin
        then "\"macism\""
        else "\"fcitx5-remote\""
      },
        -- Start in ASCII on launch, and switch back to ASCII whenever leaving
        -- insert/cmdline modes. Insert mode restores the previously used IM.
        set_default_events = { "VimEnter", "InsertLeave", "CmdlineLeave" },
        set_previous_events = { "InsertEnter" },
        keep_quiet_on_no_binary = true,
        async_switch_im = true,
      })
    '';
  };
}
