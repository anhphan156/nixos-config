{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (pkgs) callPackage;

  guiPackages =
    if config.cyanea.graphical.gui.enable
    then
      with pkgs; [
        glslviewer
        nemo
        evince
        # pureref
        beeper
        blender
        obs-studio
        zoom-us
        (callPackage ./user_scripts/rofi/search_docs.nix {
          rootPath = inputs.src;
          inherit (config.cyanea) dotfilesPath;
        })
        (callPackage ./user_scripts/rofi/dev_project.nix {basePath = lib.user.path.dev;})
      ]
    else [];
in {
  imports = [
    ./fonts
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # (vim_configurable.override { guiSupport = "gtk3"; })
    vim
    wget
    git
    cmake
    gnumake
    curl
    inputs.alejandra.defaultPackage.${pkgs.system}
    nixd
  ];

  home-manager.users."${lib.user.name}" = {
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
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

        (callPackage ./user_scripts/tmux_code_layout.nix {})
        (callPackage ./user_scripts/fzf/dev_project.nix {})
        (callPackage ./kabmat {})
      ]
      ++ guiPackages;
  };
}
