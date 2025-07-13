{
  pkgs,
  inputs,
  mylib,
  vars,
  system,
  isDarwin,
  ...
}: {
  imports = mylib.scanPaths ./.;

  # enable experimental features
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" vars.username];
    accept-flake-config = true;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org/"
      "https://ghostty.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

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

  nixpkgs = {
    hostPlatform = system;

    config.allowUnfree = true;

    # enable nur
    overlays = [
      inputs.nur.overlays.default
    ];
  };
}
