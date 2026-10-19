{
  disko.devices = {
    disk.main = {
      type = "disk";
      # External 1TB SSD (SanDisk Extreme Portable) dedicated to NixOS.
      # Windows lives on the internal NVMe SSD.
      # Use a stable ID since USB disk names (sda, sdb, ...) depend on enumeration order.
      # NOTE: This is only used when partitioning; mounts refer to partition labels.
      device = "/dev/disk/by-id/ata-SanDisk_Extreme_Portable_SSD_1951C5806703";

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
