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
    nemo
    evince
    # pureref
    beeper
    # blender
    obs-studio
    zoom-us
    discord
    vesktop
    obsidian
    keepassxc
    (callPackage "${inputs.self}/packages/scripts/rofi/search_docs.nix" {
      rofiConfig = rofiCfg.oneColumn;
    })
    (callPackage "${inputs.self}/packages/scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = rofiCfg.prompt;
      rofiImgConfig = rofiCfg.image;
    })
    (callPackage "${inputs.self}/packages/scripts/dev/devgui.nix" {
      basePath = lib.user.path.dev;
      tmux_code = callPackage "${inputs.self}/packages/scripts/dev/tmux_code_layout.nix" {};
      rofiConfig = rofiCfg.default;
    })
  ];
}
