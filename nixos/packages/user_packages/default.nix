{ pkgs, user, ... }:
{
    home-manager.users."${user.name}".home.packages = with pkgs; [
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
        #neovim
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

        ( import ../../scripts/search_docs.nix { inherit pkgs; } )
    ];
}
