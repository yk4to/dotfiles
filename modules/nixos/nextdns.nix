{
  inputs,
  config,
  ...
}: {
  services.nextdns = {
    enable = true;
    arguments = ["-config-file" "${config.age.secrets.nextdns.path}"];
  };

  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];

  age.secrets = {
    nextdns = {
      file = "${inputs.secrets}/nextdns.age";
      mode = "600";
    };
  };
}
