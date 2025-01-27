{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (pkgs) callPackage;
  cfgGui = config.cyanea.graphical.gui.enable;
in {
  imports = [
    ./fonts
  ];

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
  ];

  home-manager.users."${lib.user.name}" = {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      inherit (pkgs) overlays;
    };

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

        (callPackage ./user_scripts/dev/tmux_code_layout.nix {})
        (callPackage ./user_scripts/dev/dev_project.nix {
          guiEnabled = cfgGui;
          basePath = lib.user.path.dev;
          tmux_code = callPackage ./user_scripts/dev/tmux_code_layout.nix {};
          rofiConfig = config.dotfiles.rofi.default.path;
        })
        (callPackage ./kabmat {})
      ]
      ++ (lib.optionals cfgGui [
        anki
        glslviewer
        nemo
        evince
        # pureref
        beeper
        blender
        obs-studio
        zoom-us
        (callPackage ./user_scripts/rofi/search_docs.nix {
          rofiConfig = config.dotfiles.rofi.oneColumn;
        })
        (callPackage ./user_scripts/rofi/text_clipboard.nix {
          rofiPromptConfig = config.dotfiles.rofi.prompt;
          rofiImgConfig = config.dotfiles.rofi.image;
        })
      ]);
  };
}
