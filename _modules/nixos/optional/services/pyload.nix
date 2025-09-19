{
  lib,
  config,
  vars,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/pyload/config 0755 root root - -"
      "d /var/lib/pyload/downloads 0755 root root - -"
    ];

    virtualisation.oci-containers.containers.pyload = {
      image = "lscr.io/linuxserver/pyload-ng:latest";
      volumes = [
        "/var/lib/pyload/config:/config"
        "/var/lib/pyload/downloads:/downloads"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
        "TZ" = vars.timeZone;
      };
      ports = ["8000:8000"];
    };

    networking.firewall.allowedTCPPorts = [8000];
  };
}
