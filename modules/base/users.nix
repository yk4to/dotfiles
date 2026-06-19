{
  config,
  inputs,
  lib,
  pkgs,
  vars,
  isDarwin,
  ...
}: {
  age.secrets = lib.mkIf (!isDarwin) {
    user-password = {
      file = "${inputs.secrets}/password.age";
      mode = "600";
    };
  };

  # Define a user account.
  users.users.${vars.username} =
    {
      description = vars.userfullname;
      shell = pkgs.fish;
    }
    // (
      if isDarwin
      then {
        home = "/Users/${vars.username}";
      }
      else {
        home = "/home/${vars.username}";
        isNormalUser = true;
        extraGroups = ["wheel"];
        # password.age must contain a single mkpasswd-compatible hash line.
        hashedPasswordFile = config.age.secrets.user-password.path;
      }
    );
}
