{inputs, ...}: {
  services.nextdns = {
    enable = true;
    arguments = ["-config" "${builtins.readFile config.age.secrets.nextdns.path}"];
  };

  age.secrets = {
    nextdns = {
      file = "${inputs.secrets}/nextdns.age";
      mode = "600";
    };
  };
}
