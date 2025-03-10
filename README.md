# NixOS Config

## Screenshots

![desktop](https://i.imgur.com/0WEGVkj.png)

## Features

|Config                                                                        |                                          |
|-----------------------------------------------------                         |------------------------------------------|
|OS                                                                            |[NixOS](https://nixos.org/)               |
|[Display Manager](./modules/nixos/system/graphics/sddm/default.nix)           |[SDDM](https://github.com/sddm/sddm)      |
|[X Window Manager](./modules/nixos/system/graphics/awesome/default.nix)       |[AwesomeWM](https://awesomewm.org/)       |
|[Wayland Window Manager](./modules/nixos/system/graphics/hyprland/default.nix)|[Hyprland](https://hyprland.org/)         |
|[Shell](./modules/home-manager/dotfiles/shell/zsh.nix)                        |[Zsh](https://www.zsh.org/)               |
|[Shell Prompt](./modules/home-manager/dotfiles/shell/starship.nix)            |[Starship](https://starship.rs/)          |
|[Text Editor](https://github.com/anhphan156/nvim-config)                      |[Neovim](https://neovim.io/)              |
|[Terminal Emulator](./modules/home-manager/dotfiles/kitty/default.nix)        |[Kitty](https://sw.kovidgoyal.net/kitty/) |
|[Launcher](./modules/home-manager/dotfiles/rofi/default.nix)                  |[Rofi](https://github.com/davatorium/rofi)|

## Hosts
Desktop Hosts
+ Impermanence setup with root on tmpfs
+ Window manager: either Hyprland or AwesomeWM

Wsl Host
+ NixOS right in my Windows PC so I can use Nixvim on Windows

Installer ISO
+ An ISO that includes many tools to install a new operating system such as pacstrap, mkfs, disko, nixos-install, wget, git, etc

For more details, please have a look at [hosts](./hosts).

## References

Please check flake inputs for the stuffs I use. In addition to them, here are a few flakes that I got my inspiration from:
+ [jakehamilton/config](https://github.com/jakehamilton/config)
+ [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
+ [nmasur/dotfiles](https://github.com/nmasur/dotfiles)
