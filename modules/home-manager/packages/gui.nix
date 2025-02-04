{
  pkgs,
  inputs,
  lib,
  ...
}: let
  callPackage' = path: config: pkgs.callPackage "${inputs.self}/packages/${path}" config;
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
    (callPackage' "user_scripts/rofi/search_docs.nix" {
      rofiConfig = rofiCfg.oneColumn;
    })
    (callPackage' "user_scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = rofiCfg.prompt;
      rofiImgConfig = rofiCfg.image;
    })
    (callPackage' "user_scripts/dev/dev_project.nix" {
      guiEnabled = true;
      basePath = lib.user.path.dev;
      tmux_code = callPackage' "user_scripts/dev/tmux_code_layout.nix" {};
      rofiConfig = rofiCfg.default;
    })
  ];
}
