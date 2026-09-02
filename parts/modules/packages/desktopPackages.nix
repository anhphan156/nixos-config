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
    ];
  };
}
