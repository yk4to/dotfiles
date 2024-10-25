{
  virtualisation.arion.projects.minecraft.settings = {
    services.minecraft.service = {
      image = "itzg/minecraft-server";
      container_name = "minecraft";
      tty = true;
      environment = {
        EULA = "TRUE";
        TYPE = "PAPER";
        ENABLE_ROLLING_LOGS = "TRUE";
        INIT_MEMORY = "1G";
        MAX_MEMORY = "4G";
        TZ = "Asia/Tokyo";
        MAX_PLAYERS = "5";
        SNOOPER_ENABLED = "FALSE";
        PVP = "FALSE";
        DIFFICULTY = "normal";
      };
      ports = [
        "25565:25565/tcp"
      ];
      volumes = [
        {
          type = "volume";
          source = "minecraft";
          target = "/data";
        }
      ];
      restart = "unless-stopped";
    };

    services.mc-backup.service = {
      image = "itzg/mc-backup";
      container_name = "mc-backup";
      depends_on = ["minecraft"];
      volumes = [
        {
          type = "volume";
          source = "minecraft";
          target = "/data";
        }
        {
          type = "volume";
          source = "mc-backup";
          target = "/backups";
        }
      ];
      restart = "unless-stopped";
    };

    docker-compose.volumes = {
      minecraft = {};
      mc-backup = {};
    };
  };
}
