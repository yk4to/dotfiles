{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/memos 0755 root root - -"
    ];

    virtualisation.oci-containers.containers.memos = {
      image = "neosmemo/memos:0.24.0";
      volumes = [
        "/var/lib/memos:/var/opt/memos"
      ];
      ports = ["5230:5230"];
    };

    networking.firewall.allowedTCPPorts = [5230];
  };
}
