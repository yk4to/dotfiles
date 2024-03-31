{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.yuta = {
    home = "/Users/yuta";
    shell = "fish";
  };

  networking.hostName = "yuta-mba";

  nixpkgs.hostPlatform = "aarch64-darwin";
}