{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.linux.gui-apps.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;

      # Remove this line once all hosts are upgraded to 26.05 or higher
      configPath = "${config.xdg.configHome}/mozilla/firefox";

      profiles."dev-edition-default" = {
        settings = {
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        };

        extensions = {
          force = true;

          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            ublacklist
            refined-github
            stylus
            translate-web-pages
            control-panel-for-twitter
            wappalyzer
          ];
        };

        bookmarks = {
          force = true;
          settings = [
            {
              name = "YouTube";
              url = "https://www.youtube.com/";
            }
            {
              name = "GitHub";
              url = "https://github.com/";
            }
            {
              name = "NixOS Search - Packages";
              url = "https://search.nixos.org/packages?channel=unstable";
            }
            {
              name = "Home Manager - Option Search";
              url = "https://home-manager-options.extranix.com/";
            }
            {
              name = "Darwin Configuration Options";
              url = "https://daiderd.com/nix-darwin/manual/index.html";
            }
          ];
        };
      };
    };
  };
}
