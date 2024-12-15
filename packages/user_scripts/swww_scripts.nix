{
  writeShellScript,
  wallpaperPath,
  monitorList,
  lib,
  stdenv,
  swww,
  ...
}: let
  sm_bin = "swww_sm";
  dm_bin = "swww_dm";

  single_monitor = writeShellScript sm_bin ''
    #!/usr/bin/env bash

    wallpapers=${wallpaperPath}/single
    random=$(ls $wallpapers | shuf | head -1)
    random=$wallpapers/$random

    ${lib.strings.concatMapStringsSep "\n" (x: "${swww}/bin/swww img -o \"${x}\" --transition-type center $random") monitorList}
  '';

  dual_monitor = writeShellScript dm_bin ''
    #!/usr/bin/env bash

    wallpapers=${wallpaperPath}/dual
    random=$(ls $wallpapers | shuf | head -1)
    random=$wallpapers/$random

    convert -crop 50%x100% $random /tmp/output.png

    swww img -o "DP-1" --transition-type center /tmp/output-1.png
    swww img -o "DP-3" --transition-type center /tmp/output-0.png
  '';
in
  stdenv.mkDerivation {
    pname = "swww scripts";
    version = "1.0.0";
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin
      cp ${single_monitor} $out/bin/${sm_bin}
      cp ${dual_monitor} $out/bin/${dm_bin}
    '';
  }
