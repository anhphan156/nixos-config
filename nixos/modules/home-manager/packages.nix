{ pkgs, ... }:

{
    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        kitty
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
        mpc-cli
        (ffmpeg.override { withXcb = true; })
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

        ( import ../../scripts/search_docs.nix { inherit pkgs; } )
        ( import ../../scripts/music_retag.nix { inherit pkgs; } )
        ( import ../../scripts/spawn_ncmpcpp.nix { inherit pkgs; } )
    ];
}
