{
  pkgs,
  user,
  ...
}: {
  home-manager.users."${user.name}".home.packages = with pkgs; [
    obsidian
    cinnamon.nemo
    pureref

    cmatrix
    fastfetch
    bunnyfetch
    pamixer
    fzf
    xclip
    bat
    maim
    bc
    id3v2
    xdotool
    nix-prefetch-git
    #(ffmpeg.override { withXcb = true; })
    unzip
    fortune
    jq
    btop
    lolcat
    asciiquarium
    cbonsai
    figlet
    acpid
    mpv

    ghc
    valgrind
    gdb

    (import ../user_scripts/search_docs.nix {inherit pkgs;})
    (import ../user_scripts/tmux_code_layout.nix {inherit pkgs;})
    (import ../user_scripts/kitty_spawn/spawn_tmux_code.nix {inherit pkgs;})
  ];
}
