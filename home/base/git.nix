{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "yk4to";
    userEmail = "64204135+yk4to@users.noreply.github.com";

    extraConfig = { init.defaultBranch = "main"; };
  };

  programs.gh.enable = true;
}
