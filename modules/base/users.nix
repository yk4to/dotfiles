{
  pkgs,
  vars,
  isDarwin,
  ...
}: {
  # Define a user account.
  # Don't forget to set a password with ‘passwd’ on NixOS.
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
      }
    );
}
