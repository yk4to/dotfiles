{
  virtualisation.arion.projects.homebridge.settings = {
    services.homebridge.service = {
      image = "homebridge/homebridge:latest";
      container_name = "homebridge";
      volumes = [
        {
          type = "volume";
          source = "homebridge";
          target = "/homebridge";
        }
      ];
      restart = "always";
      nerwork_mode = "host";
      # logging = {
      #   driver = "json-file";
      #   options = {
      #     max-size = "10m";
      #     max-file = "1";
      #   };
      # };
      healthcheck = {
        test = ["CMD-SHELL" "curl --fail http://localhost:8581 || exit 1"];
        interval = "60s";
        retries = 5;
        start_period = "300s";
        timeout = "2s";
      };
    };

    docker-compose.volumes = {
      homebridge = {};
    };
  };
}
