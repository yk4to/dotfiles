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

  addons = pkgs.nur.repos.rycee.firefox-addons;

  # Add-ons missing from rycee's NUR repo, pinned to their AMO release.
  amazon-unsponsor = addons.buildFirefoxXpiAddon {
    pname = "amazon-unsponsor";
    version = "0.0.8";
    addonId = "amazon-unsponsor@github.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4461440/amazon-0.0.8.xpi";
    sha256 = "1dcee2802a1ef623f04a817a089219fc8bce836c1cd4579c1978cfaeadf9cd33";
    meta = {
      homepage = "https://github.com/Cside/amazon-unsponsor";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

  icloud-passwords = addons.buildFirefoxXpiAddon {
    pname = "icloud-passwords";
    version = "3.4.0";
    addonId = "password-manager-firefox-extension@apple.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/5070185/icloud_passwords-3.4.0.xpi";
    sha256 = "0cffb1716a9eff72e44a592bdef05e32d102d68253fdc508e5e6bdb5880ecbef";
    meta = {
      license = licenses.unfree;
      platforms = platforms.darwin;
    };
  };
in {
  imports = [inputs.zen-browser.homeModules.beta];

  options.optionalModules.base.zen-browser = {
    enable = mkEnableOption "Zen Browser";
  };

  # Ownership is split so nothing is managed twice:
  # - Nix: policies, prefs, extensions, containers (same on every machine).
  # - Zen Sync: spaces, pins, essentials, folders, bookmarks, history.
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

          # Nix owns extensions and prefs; Sync carries spaces/pins and browsing data.
          "services.sync.engine.addons" = false;
          "services.sync.engine.prefs" = false;
          "services.sync.engine.spaces" = true;
        };

        extensions = {
          force = true;

          packages =
            (with addons; [
              control-panel-for-twitter
              control-panel-for-youtube
              github-file-icons
              karakeep
              keepa
              refined-github
              stylus
              ublacklist
              ublock-origin
              wappalyzer
            ])
            ++ [amazon-unsponsor]
            ++ optional isDarwin icloud-passwords;
        };

        # Spaces refer to containers by id, and Sync does not carry containers,
        # so they are declared here to keep the ids identical across machines.
        containersForce = true;
        containers = {
          Work = {
            id = 1;
            color = "turquoise";
            icon = "briefcase";
          };
          Uni = {
            id = 2;
            color = "green";
            icon = "fingerprint";
          };
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
