{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;

    profiles."dev-edition-default" = {
      settings = {
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        ublacklist
        refined-github
        stylus
      ];
    };
  };
}
