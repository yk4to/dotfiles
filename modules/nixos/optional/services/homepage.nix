{
  inputs,
  config,
  lib,
  ...
}: {
  age.secrets.cloudflared.file = "${inputs.secrets}/homepage.age";

  config = lib.mkIf config.optionalModules.nixos.services.enable {
    services.homepage-dashboard = {
      enable = true;

      listenPort = 1000;
      openFirewall = true;
      allowedHosts = "mate.local";

      environmentFile = config.age.secrets.homepage.path;

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
                widget = {
                  type = "tailscale";
                  deviceid = "mate";
                  key = "{{HOMEPAGE_TAILSCALE_KEY}}";
                };
              };
            }
            {
              Cloudflare = {
                widget = {
                  type = "cloudflared";
                  accountid = "{{HOMEPAGE_CLOUDFLARE_ACCOUNTID}}";
                  tunnelid = "{{HOMEPAGE_CLOUDFLARE_TUNNELID}}";
                  key = "{{HOMEPAGE_CLOUDFLARE_KEY}}";
                };
              };
            }
            {
              NextDNS = {
                widget = {
                  type = "nextdns";
                  profile = "{{HOMEPAGE_NEXTDNS_PROFILE}}";
                  key = "{{HOMEPAGE_NEXTDNS_KEY}";
                };
              };
            }
          ];
          Containers = [
            {
              FreshRSS = {
                description = "RSS feed reader";
                widget = {
                  type = "freshrss";
                  url = "http://mate.local:80";
                  username = "{{HOMEPAGE_FRESHRSS_USERNAME}}";
                  password = "{{HOMEPAGE_FRESHRSS_PASSWORD}}";
                };
              };
            }
            {
              Memos = {
                description = "Self-hosted note-taking service";
                container = "memos";
                href = "http://mate.local:5230";
              };
            }
          ];
        }
      ];
    };
  };
}
