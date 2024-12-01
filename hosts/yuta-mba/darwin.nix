{
  pkgs,
  vars,
  ...
}: {
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = pkgs.fish;
  };

  networking.hostName = "yuta-mba";

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
