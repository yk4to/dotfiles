{
  virtualisation.arion.projects.memos.settings = {
    services.memos.service = {
      image = "neosmemo/memos:0.22.4";
      container_name = "memos";
      volumes = [
        {
          type = "volume";
          source = "memos";
          target = "/var/opt/memos";
        }
      ];
      ports = ["5230:5230"];
      restart = "unless-stopped";
    };

    docker-compose.volumes = {
      memos = {};
    };
  };
}
