{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  rofiCfg = config.dotfiles.rofi;
in {
  home.packages = with pkgs; [
    anki
    glslviewer





    obs-studio

    discord

    obsidian
    keepassxc
    baobab
    (callPackage "${inputs.self}/packages/scripts/rofi/search_docs.nix" {
      rofiConfig = rofiCfg.oneColumn;
    })
    (callPackage "${inputs.self}/packages/scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = rofiCfg.prompt;
      rofiImgConfig = rofiCfg.image;
    })
  ];
}
