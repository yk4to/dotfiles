{pkgs, ...}: let
  inkdrop = pkgs.callPackage ../../packages/inkdrop.nix {};
in {
  home.packages = [inkdrop];
}
