{
  flake.nixosModules = {
    packages = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
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

        fd
        ripgrep
        wget
        curl
        cachix
        gnumake
        killall
        cmatrix
        pamixer
        fzf
        bat
        bc
        id3v2
        nix-prefetch-git
        unzip
        zip
        unrar
        jq
        btop
        figlet
        acpid
        mpv
        yt-dlp
        ffmpeg
        cava
        python3
        entr
        tree
        man-pages
        pass
        yubikey-manager
        yazi
        zathura
        discord
        keepassxc
        baobab
      ];
    };
  };
}
