{
  flake.modules.nixos.desktop = { pkgs, ... }: {
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
      bat
      bc
      id3v2
      nix-prefetch-git
      unzip
      zip
      unrar
      jq
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
    ];
  };
}
