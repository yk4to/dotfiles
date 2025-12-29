{
  inputs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    age.secrets.homepage.file = "${inputs.secrets}/homepage.age";

    services.homepage-dashboard = {
      enable = true;

      listenPort = 10000;
      openFirewall = true;
      allowedHosts = "mate.local:10000";

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
                icon="tailscale.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "{{HOMEPAGE_VAR_TAILSCALE_DEVICEID}}";
                  key = "{{HOMEPAGE_VAR_TAILSCALE_KEY}}";
                };
              };
            }
            {
              Cloudflare = {
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
                description = "RSS feed reader";
                widget = {
                  type = "freshrss";
                  url = "http://mate.local:80";
                  username = "{{HOMEPAGE_VAR_FRESHRSS_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_FRESHRSS_PASSWORD}}";
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
