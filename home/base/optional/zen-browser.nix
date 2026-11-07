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

  # Science Tokyo auto-login; credentials are set in each add-on's options page.
  titech-authenticator = addons.buildFirefoxXpiAddon {
    pname = "titech-authenticator";
    version = "1.0.3resigned1";
    addonId = "titech-authenricator@hallelujahdrive.github.io";
    url = "https://addons.mozilla.org/firefox/downloads/file/4275145/titech_authenticator-1.0.3resigned1.xpi";
    sha256 = "1c661571e13bfa7b4193f0063f822d196d7abfdeb472138b8a9b0c94bf2a557d";
    meta = {
      homepage = "https://github.com/hallelujahdrive/Titech-Authenticator";
      license = licenses.wtfpl;
      platforms = platforms.all;
    };
  };

  isct-login = addons.buildFirefoxXpiAddon {
    pname = "isct-login";
    version = "1.0.1";
    addonId = "isct-login@github.sheat.tokyo";
    url = "https://raw.githubusercontent.com/oha-4/ISCT-Login/ca66f036a11d62172d813c8f0000d1dc57e9539a/firefox/releases/1.0.1.xpi";
    sha256 = "658799676a4112d696276ae5899fbeb2f9dac1154b7482d80c1ab62695ed7731";
    meta = {
      homepage = "https://github.com/oha-4/ISCT-Login";
      license = licenses.unfree;
      platforms = platforms.all;
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

          "intl.locale.requested" = "ja,en-US";

          # macOS window backdrop: underWindowBackground instead of the default hudWindow,
          # the closest of Zen's options to the native sidebar material.
          "zen.widget.macos.window-material" = 7;

          # Pop playing videos out into Picture-in-Picture when switching tabs.
          "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;

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
            ++ [amazon-unsponsor isct-login titech-authenticator]
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
  };
}
