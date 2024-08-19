{
  pkgs,
  vars,
  inputs,
  system,
  ...
}: {
  # Install agenix
  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets = {
    freshrss = {
      file = "${inputs.secrets}/freshrss.age";
      mode = "600";
    };
    nextdns = {
      file = "${inputs.secrets}/nextdns.age";
      mode = "600";
    };
    cloudflared = {
      file = "${inputs.secrets}/cloudflared.age";
      owner = "cloudflared";
      group = "cloudflared";
    };
  };
}
