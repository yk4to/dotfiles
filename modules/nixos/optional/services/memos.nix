{
  virtualisation.arion.projects.memos.settings = {
    services.memos = {
      service.image = "neosmemo/memos:version-0.22.4";
      service.container_name = "memos";
      service.volumes = [
        {
          type = "volume";
          source = "memos";
          target = "/var/opt/memos";
        }
      ];
      service.ports = ["5230:5230"];
      service.restart = "unless-stopped";
    };

    docker-compose.volumes = {
      memos = {};
    };
  };
}
