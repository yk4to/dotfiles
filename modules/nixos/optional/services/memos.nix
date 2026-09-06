{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /srv/data/memos 0755 root root - -"
    ];

    virtualisation.oci-containers.containers.memos = {
      image = "docker.io/neosmemo/memos:0.30.0";
      volumes = [
        "/srv/data/memos:/var/opt/memos"
      ];
      ports = ["5230:5230"];
      environment = {
        "MEMOS_INSTANCE_URL" = "https://memos.fus1on.dev";
      };
    };

    networking.firewall.allowedTCPPorts = [5230];
  };
}
