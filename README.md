# dotfiles

## Hosts

- ThinkPad P14s Gen 4
  - `thinkpad`
  - NixOS 24.11 (dual-boot with Windows 11)
  - i7 1360P, 32GB RAM
- MacBook Air 2024
  - `yuta-mba`
  - macOS Sonoma (managed by nix-darwin)
  - M3, 16GB RAM
- Raspberry Pi 4 Model B Rev 1.4
  - `raspi4`
  - NixOS 24.11 (booted with USB-connected SATA SSD)
  - Cortex-A72, 8GB RAM

## Stacks

### Base
- Nix
  - Home Manager
  - formatter: alejandra
- shell: Fish
- prompt: Starship ([asynchronous loading](https://gist.github.com/duament/bac0181935953b97ca71640727c9c029))
- terminal emulator: Ghostty (private beta)
- editor: VSCode, Neovim
  - lazy.nvim
- font: UDEV Gothic
- theme: Atom One Dark
- tools
  - eza (`ls` replacement)
  - zoxide (`cd` replacement)
  - hyperfine (benchmarking tool)
  - bottom (system monitor)
- Git-related tools
  - commitizen
  - lazygit
- 1Password (to manage SSH secrets)
- TexLive
- PlatformIO

### Linux
- vm: Gnome, Hyprland
- Hyprland-related tools (🚧 WIP)
  - swaylock
  - swaync
  - waybar
  - wofi

### macOS

- nix-darwin
  - nix-darwin-custom-icons
- Homebrew (for Casks only)
- mas (to install App Store apps via Homebrew)
- tools
  - trash
- OrbStack (`docker` replacement)

## References

Inspired by

- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
- [natsukium/dotfiles](https://github.com/natsukium/dotfiles)
- [asa1984/dotfiles](https://github.com/asa1984/dotfiles)
- [H1rono/dotfiles](https://github.com/H1rono/dotfiles)