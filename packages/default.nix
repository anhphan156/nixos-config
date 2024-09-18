{
  user,
  inputs,
  pkgs,
  config,
  ...
}: let
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
        (import ./user_scripts/rofi/search_docs.nix {inherit pkgs user;})
        (import ./user_scripts/kitty_spawn/spawn_tmux_code.nix {inherit pkgs;})
        (import ./user_scripts/rofi/dev_project.nix {inherit pkgs;})
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
  ];

  home-manager.users."${user.name}" = {
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    home.packages = with pkgs;
      [
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

        (import ./user_scripts/tmux_code_layout.nix {inherit pkgs;})
        (import ./user_scripts/fzf/dev_project.nix {inherit pkgs;})
        (import ./kabmat pkgs)
      ]
      ++ guiPackages;
  };
}
