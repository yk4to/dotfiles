{vars, ...}: {
  # enable experimental features
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [vars.username];
  };
}
