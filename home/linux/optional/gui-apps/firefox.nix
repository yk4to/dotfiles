{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.linux.gui-apps.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;

      profiles."dev-edition-default" = {
        settings = {
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          ublacklist
          refined-github
          stylus
          translate-web-pages
          control-panel-for-twitter
          wappalyzer
        ];
      };
    };
  };
}
