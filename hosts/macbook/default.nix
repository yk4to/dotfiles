{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.yk4to = {
    home = "/Users/yk4to";
    shell = "fish";
  };

  networking.hostName = "yuta-mba";
}