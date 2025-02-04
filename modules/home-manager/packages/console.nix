{
  pkgs,
  inputs,
  ...
}: let
  callPackage' = path: config: pkgs.callPackage "${inputs.self}/packages/${path}" config;
in {
  home.packages = with pkgs; [
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

    (callPackage' "user_scripts/dev/tmux_code_layout.nix" {})
    (callPackage' "kabmat" {})
  ];
}
