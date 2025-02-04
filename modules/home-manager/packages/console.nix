{
  pkgs,
  inputs,
  ...
}: {
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

    (callPackage "${inputs.self}/packages/scripts/dev/tmux_code_layout.nix" {})
    (callPackage "${inputs.self}/packages/kabmat" {})
  ];
}
