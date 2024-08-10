{pkgs}: let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/anhphan156/dotfiles/main/config/kitty/firefly.jpg";
    #sha256 = "1mgv2vi991mq0zz9gi3ds57fzlk7cxjcvrqs5j1iww2qvw6vgr4s";
    sha256 = "sha256-ff6nwpBFrebs1nri1C0yuTZ4mExXIubQsWHc/G4NKag=";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-theme";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };
    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out
      rm Background.jpg
      cp -r ${image} $out/Background.jpg
    '';
  }
