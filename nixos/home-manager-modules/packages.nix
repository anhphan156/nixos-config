{ pkgs, config, ... }:
let
    music_utils = if config.ncmpcpp.enable then
        with pkgs; [ 
            ( import ../scripts/spawn_ncmpcpp.nix { inherit pkgs; } )
            ( import ../scripts/music_retag.nix { inherit pkgs; } )
            mpc-cli
        ]
    else
        [];
in
{
    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        discord
        obsidian
        cinnamon.nemo
        pureref

        cmatrix
        fastfetch
        bunnyfetch
        #pfetch
        pamixer
        fzf
        xclip
        bat
        maim
        bc
        id3v2
        xdotool
        nix-prefetch-git
        neovim
        (ffmpeg.override { withXcb = true; })
        unzip
        fortune
        jq
        btop
        lolcat
        asciiquarium
        cbonsai
        figlet
        acpid

        #font-manager
        arandr
        #xorg.xrandr
        #lxappearance

        ghc
        valgrind

        ( import ../scripts/search_docs.nix { inherit pkgs; } )
    ] ++ music_utils;
}
