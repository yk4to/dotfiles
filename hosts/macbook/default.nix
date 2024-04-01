{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.yuta = {
    home = "/Users/yuta";
    shell = pkgs.fish;
  };

  networking.hostName = "yuta-mba";

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}