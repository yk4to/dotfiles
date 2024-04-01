{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
  ];

  # set time zone
  time.timeZone = "Asia/Tokyo";

  nixpkgs.config.allowUnfree = true;

  # enable auto optimisation and gc
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}