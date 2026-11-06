{
  pkgs,
  lib,
  config,
  inputs,
  isDarwin,
  ...
}:
with lib; let
  cfg = config.optionalModules.base.zen-browser;
in {
  imports = [inputs.zen-browser.homeModules.beta];

  options.optionalModules.base.zen-browser = {
    enable = mkEnableOption "Zen Browser";
  };

  config = mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;

      # On macOS the app is installed by modules/darwin/zen-browser.nix, which copies it
      # into /Applications/Nix Apps; Home Manager would only symlink it into ~/Applications.
      package = mkIf isDarwin null;

      # Writes xdg.mimeApps, which only exists on Linux.
      setAsDefaultBrowser = !isDarwin;

      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DisablePocket = true;
        DisableFirefoxStudies = true;
        DisableFeedbackCommands = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

      profiles.default = {
        settings = {
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "extensions.autoDisableScopes" = 0;
          "zen.welcome-screen.seen" = true;
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

    # The pinned Home Manager drops `policies` on macOS, so hand them to Zen through
    # its defaults domain, where Gecko reads enterprise policies on macOS.
    targets.darwin.defaults."app.zen-browser.zen" = mkIf isDarwin ({
        EnterprisePoliciesEnabled = true;
      }
      // config.programs.zen-browser.policies);
  };
}
