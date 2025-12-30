{
  inputs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    age.secrets.homepage.file = "${inputs.secrets}/homepage.age";

    systemd.services.homepage-dashboard = {
      serviceConfig = {
        SupplementaryGroups = ["podman"];
      };
    };

    services.homepage-dashboard = {
      enable = true;

      listenPort = 10000;
      openFirewall = true;
      allowedHosts = "mate.local:10000";

      environmentFile = config.age.secrets.homepage.path;

      docker.podman.socket = "/run/podman/podman.sock";

      widgets = [
        {
          greeting = {
            text_size = "4xl";
            text = "Homelab";
          };
        }
        {
          resources = {
            expanded = true;
            cpu = true;
            memory = true;
            disk = "/";
            uptime = true;
            diskUnits = "bytes";
            network = true;
          };
        }
      ];

      services = [
        {
          Networks = [
            {
              Tailscale = {
                icon = "tailscale-light.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "{{HOMEPAGE_VAR_TAILSCALE_DEVICEID}}";
                  key = "{{HOMEPAGE_VAR_TAILSCALE_KEY}}";
                };
              };
            }
            {
              Cloudflare = {
                icon = "cloudflare.svg";
                widget = {
                  type = "cloudflared";
                  accountid = "{{HOMEPAGE_VAR_CLOUDFLARE_ACCOUNTID}}";
                  tunnelid = "{{HOMEPAGE_VAR_CLOUDFLARE_TUNNELID}}";
                  key = "{{HOMEPAGE_VAR_CLOUDFLARE_KEY}}";
                };
              };
            }
            {
              NextDNS = {
                icon = "nextdns.svg";
                widget = {
                  type = "nextdns";
                  profile = "{{HOMEPAGE_VAR_NEXTDNS_PROFILE}}";
                  key = "{{HOMEPAGE_VAR_NEXTDNS_KEY}}";
                };
              };
            }
          ];
        }
        {
          Containers = [
            {
              FreshRSS = {
                icon = "freshrss.svg";
                description = "RSS feed reader";
                server = "podman";
                container = "freshrss";
                href = "http://mate.local:80";
                widget = {
                  type = "freshrss";
                  url = "http://mate.local:80";
                  username = "{{HOMEPAGE_VAR_FRESHRSS_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_FRESHRSS_PASSWORD}}";
                };
              };
            }
            {
              RSSHub = {
                icon = "rsshub.png";
                description = "RSS feed generator";
                server = "podman";
                container = "rsshub";
                href = "http://mate.local:1200";
              };
            }
            {
              RSS-Bridge = {
                icon = "rss-bridge.svg";
                description = "RSS feed bridge";
                server = "podman";
                container = "rss-bridge";
                href = "http://mate.local:3000";
              };
            }
            {
              Memos = {
                icon = "memos.png";
                description = "Self-hosted note-taking service";
                server = "podman";
                container = "memos";
                href = "http://mate.local:5230";
              };
            }
            {
              Karakeep = {
                icon = "karakeep.svg";
                description = "Knowledge management system";
                server = "podman";
                container = "karakeep";
                href = "http://mate.local:5000";
              };
            }
          ];
        }
        {
          "Smart Home" = [
            {
              Homebridge = {
                icon = "homebridge.svg";
                description = "HomeKit bridge for smart home devices";
                href = "http://homebridge.local";
                widget = {
                  type = "homebridge";
                  url = "http://homebridge.local";
                  username = "{{HOMEPAGE_VAR_HOMEBRIDGE_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_HOMEBRIDGE_PASSWORD}}";
                };
              };
            }
          ];
        }
      ];
    };
  };
}
