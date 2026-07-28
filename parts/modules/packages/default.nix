{
  flake.nixosModules = {
    packages = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        cachix

        gcc
        llvmPackages.clang-tools
        valgrind
        gdb
        gf

        fd
        ripgrep
        wget
        curl
        file
        gnumake
        (
          buildFHSEnv
          <|
            appimageTools.defaultFhsEnvArgs
            // {
              name = "fhs";
              profile = "export FHS=1";
              runScript = "zsh";
              extraOutputsToInstall = [ "dev" ];
            }
        )

        killall
        cmatrix
        bunnyfetch
        pamixer
        fzf
        bat
        bc
        id3v2
        nix-prefetch-git
        ffmpeg
        unzip
        zip
        unrar
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
        tree
        man-pages
        ascii

        zathura
        discord
        keepassxc
        baobab
      ];
    };
  };
}
