{ pkgs, ... }:
let
    image = pkgs.fetchurl {
        url = "";

    };
in
{
    pkgs.stdenv.mkDerivation {
        name = "sddm-theme";
        src = pkgs.fetchFromGithub {
            owner = "";
            repo = "";
            rev = "";
            sha256 = "";
        };
        installPhase = ''
            mkdir -p $out
            cp -R ./* $out/
            cd $out
            rm Background.jpg
            cp ${image} $out/Background.jpg
        '';
    };
}
