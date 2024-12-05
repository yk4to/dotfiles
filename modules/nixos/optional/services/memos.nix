{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    virtualisation.oci-containers.containers.memos = {
      image = "neosmemo/memos:0.22.5";
      volumes = [
        "memos:/var/opt/memos"
      ];
      ports = ["5230:5230"];
      extraOptions = [
        "--restart=unless-stopped"
      ];
    };

    networking.firewall.allowedTCPPorts = [5230];
  };
}
