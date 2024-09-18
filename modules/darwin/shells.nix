{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh pkgs.fish];
    loginShell = pkgs.fish;

    systemPackages = with pkgs; [
      fish
    ];
  };

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };
}
