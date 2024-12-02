# dotfiles

![](https://img.shields.io/badge/NixOS-unstable-informational.svg?style=for-the-badge&logo=nixos)
![](https://img.shields.io/badge/macOS-Sequoia-informational.svg?style=for-the-badge&logo=apple)

## Hosts

See [./hosts](./hosts) for details.

## Stacks

### Base (shared on macOS and Linux)

| | Managed by [Nix](https://github.com/NixOS/nix) and [Home Manager](https://github.com/nix-community/home-manager) |
| - | - |
| Shell | [Fish](https://github.com/fish-shell/fish-shell) |
| Shell Prompt | [Starship](https://github.com/starship/starship) |
| Terminal Emulator | [Ghostty](https://mitchellh.com/ghostty) |
| Editor | [VSCode](https://github.com/microsoft/vscode), [Neovim](https://github.com/neovim/neovim) |
| Font | [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono), [UDEV Gothic](https://github.com/yuru7/udev-gothic) 🇯🇵 |
| Color Scheme | Atom One Dark ([VSCode](https://github.com/Binaryify/OneDark-Pro), [Neovim](https://github.com/olimorris/onedarkpro.nvim)) |
| Nix Formatter | [Alejandra](https://github.com/kamadorueda/alejandra) |
| Secret Management | [ragenix](https://github.com/yaxitech/ragenix) |
| System Monitor | [bottom](https://github.com/ClementTsang/bottom) |
| Git-related Tools | [Commitizen](https://github.com/commitizen-tools/commitizen), [Lazygit](https://github.com/jesseduffield/lazygit), [delta](https://github.com/dandavison/delta) |
| Modern CLI Tools | [zoxide](https://github.com/ajeetdsouza/zoxide), [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat) |
| Other CLI Tools | [direnv](https://github.com/direnv/direnv), [just](https://github.com/casey/just), [hyperfine](https://github.com/sharkdp/hyperfine), ... |
| VPN | [Tailscale](https://github.com/tailscale/tailscale) |

#### Neovim plugins

| | Managed by Nix |
| - | - |
| Plugin Manager | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| File Tree | [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) |
| Statusline | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |

### macOS

| | Managed by [nix-darwin](https://github.com/LnL7/nix-darwin) |
| - | - |
| GUI Apps Manager | [Homebrew Cask](https://github.com/Homebrew/homebrew-cask), [mas](https://github.com/mas-cli/mas) |
| Container System | [OrbStack](https://orbstack.dev) (Docker replacement) |

### Linux

| | NixOS |
| - | - |
| Desktop Environment | [GNOME](https://gitlab.gnome.org/GNOME/gnome-shell) |
| Window Manager | [Pop Shell](https://github.com/pop-os/shell) |
| Container System | [Arion](https://github.com/hercules-ci/arion) (Docker helper for NixOS) |
| Self-Hosted Services | [FreshRSS](https://github.com/FreshRSS/FreshRSS), [Memos](https://github.com/usememos/memos), [Homebridge](https://github.com/homebridge/homebridge) |
| Private Network | [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/) |
| Secure Boot | [Lanzaboote](https://github.com/nix-community/lanzaboote) |

## References

Inspired by

- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
- [natsukium/dotfiles](https://github.com/natsukium/dotfiles)
- [asa1984/dotfiles](https://github.com/asa1984/dotfiles)
- [H1rono/dotfiles](https://github.com/H1rono/dotfiles)