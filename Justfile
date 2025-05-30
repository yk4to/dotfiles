# ref: https://github.com/ryan4yin/nix-config/blob/main/Justfile

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

[macos]
[group('desktop')]
switch name:
  nom build ".#darwinConfigurations.{{name}}.system" --extra-experimental-features "nix-command flakes"
  sudo darwin-rebuild switch --flake .#{{name}}

[linux]
[group('desktop')]
switch name:
  nom build ".#nixosConfigurations.{{name}}.config.system.build.toplevel" --extra-experimental-features "nix-command flakes"
  nixos-rebuild switch --use-remote-sudo --flake .#{{name}}