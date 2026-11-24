{
  config,
  inputs,
  vars,
  ...
}: {
  # Holds `access-tokens = github.com=<token>`; owned by the user since nh evaluates as them
  age.secrets.nix-github-token = {
    file = "${inputs.secrets}/nix-github-token.age";
    owner = vars.username;
    mode = "400";
  };

  # `!include` skips a missing file, so the first switch can use NIX_CONFIG instead
  nix.extraOptions = ''
    !include ${config.age.secrets.nix-github-token.path}
  '';

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" vars.username];
    accept-flake-config = true;

    # Optimise the store automatically during every build
    auto-optimise-store = true;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://noctalia.cachix.org"
      "https://cache.numtide.com"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
}
