{
  programs.git = {
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKyEcrKmm/9CLZSzfaEqQ6VFjgXemIFpcdpIwrg1PYVy";
      signByDefault = true;
    };

    extraConfig = {
      commit.gpgsign = true;

      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
      };
    };
  };
}