{
  vars,
  isDarwin,
  ...
}: {
  programs.nh = {
    enable = true;

    # Sets `NH_FLAKE`, so `nh os/darwin switch` works from any directory
    flake =
      if isDarwin
      then "/Users/${vars.username}/dotfiles"
      else "/home/${vars.username}/dotfiles";

    # Periodic garbage collection (replaces `nix.gc`)
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  # Show activation output on `nh os/darwin switch` instead of hiding it
  environment.variables.NH_SHOW_ACTIVATION_LOGS = "1";
}
