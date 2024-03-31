{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
  ];

  # set time zone
  time.timeZone = "Asia/Tokyo";

  # enable flakes, and set config about optimisation and gc
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}