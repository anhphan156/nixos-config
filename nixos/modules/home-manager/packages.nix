{ pkgs }:

{
    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        kitty
        discord
        obsidian
        cinnamon.nemo
        pureref

        ranger
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
        neovim
        mpc-cli
        (ffmpeg.override { withXcb = true; })
        fortune

        font-manager
        arandr
        #xorg.xrandr
        lxappearance

        tokyonight-gtk-theme
        paper-gtk-theme

        ghc

        ( import ../../scripts/search_docs.nix { inherit pkgs; } )
        ( import ../../scripts/music_retag.nix { inherit pkgs; } )
        ( import ../../scripts/spawn_ncmpcpp.nix { inherit pkgs; } )
    ];
}
