{
  inputs,
  lib,
  config,
  ...
}: let
  tunnelId = "bed69fbf-bc28-4eea-9d9e-be8d6601dc76";
in {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    services.cloudflared = {
      enable = true;

      tunnels = {
        "${tunnelId}" = {
          credentialsFile = config.age.secrets.cloudflared.path;
          ingress = {
            "rss.fus1on.dev" = "http://localhost:80";
            "memos.fus1on.dev" = "http://localhost:5230";
            "karakeep.fus1on.dev" = "http://localhost:5000";
          };
          default = "http_status:404";
        };
      };
    };

    # cloudflared requires a reliable DNS for SRV lookups; avoid system DNS.
    systemd.services."cloudflared-tunnel-${tunnelId}" = {
      serviceConfig.Environment = [
        "TUNNEL_DNS=1.1.1.1"
      ];
    };

    age.secrets.cloudflared.file = "${inputs.secrets}/cloudflared.age";
  };
}
