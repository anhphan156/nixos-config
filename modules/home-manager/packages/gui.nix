{
  pkgs,
  inputs,
  lib,
  ...
}: let
  evaluated = lib.evalModules {
    specialArgs = {inherit pkgs;};
    modules = [
      inputs.dotfiles.nixosModules.default
    ];
  };
  rofiCfg = evaluated.config.dotfiles.rofi;
in {
  home.packages = with pkgs; [
    anki
    glslviewer
    nemo
    evince
    # pureref
    beeper
    blender
    obs-studio
    zoom-us
    (callPackage "${inputs.self}/packages/user_scripts/rofi/search_docs.nix" {
      rofiConfig = rofiCfg.oneColumn;
    })
    (callPackage "${inputs.self}/packages/user_scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = rofiCfg.prompt;
      rofiImgConfig = rofiCfg.image;
    })
    (callPackage "${inputs.self}/packages/user_scripts/dev/dev_project.nix" {
      guiEnabled = true;
      basePath = lib.user.path.dev;
      tmux_code = callPackage "${inputs.self}/packages/user_scripts/dev/tmux_code_layout.nix" {};
      rofiConfig = rofiCfg.default;
    })
  ];
}
