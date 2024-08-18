{config, ...}: {
  services.freshrss = {
    enable = true;

    defaultUser = "yuta";
    passwordFile = config.age.secrets.freshrss.path;

    baseUrl = "https://rss.yk4to.com";

    database.type = "sqlite";

    dataDir = "/var/lib/freshrss";
  };
}
