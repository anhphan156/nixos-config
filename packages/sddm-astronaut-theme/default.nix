{
  stdenv,
  fetchFromGitHub,
  formats,
  theme ? "hyprland_kath",
  ...
}:
stdenv.mkDerivation
{
  pname = "sddm-astronaut-theme";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "11c0bf6147bbea466ce2e2b0559e9a9abdbcc7c3";
    sha256 = "sha256-gBSz+k/qgEaIWh1Txdgwlou/Lfrfv3ABzyxYwlrLjDk=";
  };

  installPhase = let
    desktopMeta = (formats.ini {}).generate "metadata.desktop" {
      SddmGreeterTheme = {
        ConfigFile = "Themes/${theme}.conf";
        QtVersion = 6;
      };
    };
  in ''
    cp -r --no-preserve=mode $src $out
    cp ${desktopMeta} $out/metadata.desktop
  '';
}
