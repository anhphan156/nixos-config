{ moduleWithSystem, ... }: {
  flake.modules.nixos.desktop = moduleWithSystem (
    { self', ... }: { pkgs, lib, ... }: {
      environment.systemPackages =
        let
          fhs =
            pkgs.buildFHSEnv
            <|
              pkgs.appimageTools.defaultFhsEnvArgs
              // {
                name = "fhs";
                profile = "export FHS=1";
                runScript = "zsh";
                extraOutputsToInstall = [ "dev" ];
              };

          memeGen = pkgs.makeDesktopItem {
            name = "MemeGenerator";
            exec = lib.getExe self'.packages.memeGen;
            comment = "Meme generator";
            desktopName = "Meme Generator";
            genericName = "Meme Generator";
            categories = [ "Utility" ];
          };

        in
        with pkgs;
        [
          fhs
          cmatrix
          pamixer
          bat
          bc
          id3v2
          unrar
          btop
          mpv
          yt-dlp
          ffmpeg
          python3
          entr
          tree
          man-pages
          pass
          yubikey-manager
          sbctl
          nom
          just
          nmap
          discord
          vesktop
          signal-desktop
          qbittorrent
          baobab
          memeGen
          self'.packages.cakeWallet
        ];
    }
  );
}
