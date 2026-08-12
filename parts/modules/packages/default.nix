{
  flake.nixosModules = {
    packages = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        (pass.withExtensions (p: [
          (p.pass-import.overrideAttrs {
            postPatch = ''
              touch "share/man/man1/pass-import.1"
              touch "share/man/man1/pimport.1"
            '';
            src = pkgs.fetchFromGitHub {
              owner = "roddhjav";
              repo = "pass-import";
              rev = "d1c92a9daa85bc68b3957e09e964cfaeb14457c6";
              hash = "sha256-JpI61leMoSuCxn1Rl2kLozJ3wrj321Z/v+Hcy/+SIHI=";
            };
          })
        ]))

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
        ffmpeg
        unzip
        zip
        unrar
        jq
        btop
        figlet
        acpid
        mpv
        yt-dlp
        cava
        python3
        entr
        tree
        man-pages
        yubikey-manager

        zathura
        discord
        keepassxc
        baobab
      ];
    };
  };
}
