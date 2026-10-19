{
  disko.devices = {
    disk.main = {
      type = "disk";
      # 1TB SSD dedicated to NixOS. Windows lives on a separate SSD.
      # NOTE: This is only used when partitioning; mounts refer to partition labels.
      device = "/dev/sda";

      content = {
        type = "gpt";

        partitions = {
          boot = {
            # Leave room for many generations and the EFI shell.
            size = "1G";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["fmask=0077" "dmask=0077"];
            };
          };

          root = {
            size = "100%";

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
