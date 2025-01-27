{
  stdenvNoCC,
  fetchFromGitHub,
  theme ? "hyprland_kath",
  userTheme ? null,
  kdePackages,
  lib,
  formats,
  ...
}: let
  name = "sddm-astronaut-theme";
in
  stdenvNoCC.mkDerivation
  {
    inherit name;
    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "11c0bf6147bbea466ce2e2b0559e9a9abdbcc7c3";
      sha256 = "sha256-gBSz+k/qgEaIWh1Txdgwlou/Lfrfv3ABzyxYwlrLjDk=";
    };

    dontWrapQtApps = true;
    dontBuild = true;

    propagatedBuildInputs = with kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];

    installPhase =
      ''
        themedir="$out/share/sddm/themes/${name}"

        install -dm755 $themedir
        cp -r ./* $themedir

        substituteInPlace "$themedir/metadata.desktop" \
          --replace "ConfigFile=Themes/astronaut.conf" "ConfigFile=Themes/${theme}.conf"

        install -dm755 "$out/share/fonts"
        cp -r ./Fonts/* "$out/share/fonts"
      ''
      + (lib.optionalString (lib.isAttrs userTheme) ''
        cp ${(formats.ini {}).generate "astronautUserTheme" userTheme} $themedir/Themes/${theme}.conf.user
      '');
  }
