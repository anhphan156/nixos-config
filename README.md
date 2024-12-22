# NixOS Config

This flake provides system configuration for my NixOS computers, which share many common services and features.

## Features

|Config                                                                  |                                          |
|-----------------------------------------------------                   |------------------------------------------|
|OS                                                                      |[NixOS](https://nixos.org/)               |
|[Display Manager](./modules/system/graphics/sddm/default.nix)           |[SDDM](https://github.com/sddm/sddm)      |
|[X Window Manager](./modules/system/graphics/awesome/default.nix)       |[AwesomeWM](https://awesomewm.org/)       |
|[Wayland Window Manager](./modules/system/graphics/hyprland/default.nix)|[Hyprland](https://hyprland.org/)         |
|[Shell](./modules/terminal/shell/zsh.nix)                               |[Zsh](https://www.zsh.org/)               |
|[Shell Prompt](./modules/terminal/shell/starship/default.nix)           |[Starship](https://starship.rs/)          |
|[Text Editor](./modules/terminal/nixvim/default.nix)                    |[Neovim](https://neovim.io/)              |
|[Terminal Emulator](./modules/terminal/kitty/default.nix)               |[Kitty](https://sw.kovidgoyal.net/kitty/) |
|[Launcher](./modules/applications/rofi/default.nix)                     |[Rofi](https://github.com/davatorium/rofi)|

## Hosts
Desktop Hosts
+ Impermanence setup with root on tmpfs
+ Window manager: either Hyprland or AwesomeWM (up to my mood)

Wsl Host
+ NixOS right in my Windows PC so I can use Nixvim on Windows

For more details, please have a look at [hosts](./hosts).

## References

Please check flake inputs for the stuffs I use. In addition to them, here are a few flakes that I got my inspiration from:
+ [jakehamilton/config](https://github.com/jakehamilton/config)
+ [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
+ [nmasur/dotfiles](https://github.com/nmasur/dotfiles)
