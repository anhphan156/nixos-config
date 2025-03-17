{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    "${inputs.self}/modules/home-manager/home.nix"
    "${inputs.self}/modules/home-manager/dotfiles/git"
    "${inputs.self}/modules/home-manager/dotfiles/rofi"
    "${inputs.self}/modules/home-manager/dotfiles/kitty"
    "${inputs.self}/modules/home-manager/dotfiles/fastfetch"
    "${inputs.self}/modules/home-manager/dotfiles/shell/zsh.nix"
    "${inputs.self}/modules/home-manager/dotfiles/shell/starship.nix"
  ];

  programs.fastfetch.settings.logo = lib.mkForce "${pkgs.wallpapers}/fetch_logo/sw.png";

  home.packages = with pkgs; [
    neovim
    (callPackage "${inputs.self}/packages/scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = config.dotfiles.rofi.prompt;
      rofiImgConfig = config.dotfiles.rofi.image;
    })
  ];
}
