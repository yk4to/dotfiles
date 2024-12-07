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
      image = "neosmemo/memos:0.22.5";
      volumes = [
        "var/lib/memos:/var/opt/memos"
      ];
      ports = ["5230:5230"];
      extraOptions = [
        "--restart=unless-stopped"
      ];
    };

    networking.firewall.allowedTCPPorts = [5230];
  };
}
