{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  guiCfg = config.cyanea.graphical.gui.enable;
  rofiCfg = config.dotfiles.rofi;
in {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cmake
    gnumake
    curl
    file
    neovim
    cachix
    alejandra
    gcc
    (buildFHSEnv
      <| appimageTools.defaultFhsEnvArgs
      // {
        name = "fhs";
        profile = "export FHS=1";
        runScript = "zsh";
        extraOutputsToInstall = ["dev"];
      })
  ];

  home-manager.users.${lib.user.name} = {pkgs, ...}: {
    home.packages = with pkgs;
      [
        killall
        cmatrix
        bunnyfetch
        pamixer
        fzf
        bat
        bc
        id3v2
        nix-prefetch-git
        # (ffmpeg.override {withXcb = true;})
        ffmpeg
        unzip
        zip
        unrar
        fortune
        jq
        btop
        lolcat
        asciiquarium
        cbonsai
        figlet
        acpid
        mpv
        yt-dlp
        cava
        python3
        entr
        tree
        man-pages
        ascii
      ]
      ++ lib.optionals guiCfg [
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
  };
}
