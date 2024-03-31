{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
  ];

  # set time zone
  time.timeZone = "Asia/Tokyo";
}