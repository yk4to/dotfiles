{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.yuta = {
    home = "/Users/yuta";
    shell = pkgs.fish;
  };

  networking.hostName = "yuta-mba";

  nixpkgs.hostPlatform = "aarch64-darwin";
}