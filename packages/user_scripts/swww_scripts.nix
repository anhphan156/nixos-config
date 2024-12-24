{
  writeShellApplication,
  wallpapers,
  monitorList,
  lib,
  symlinkJoin,
  swww,
  ...
}: let
  single_monitor = writeShellApplication {
    name = "swww_sm";
    runtimeInputs = [swww];
    text = ''
      wallpapers=${wallpapers}/single
      # shellcheck disable=SC2012
      random=$(ls $wallpapers | shuf | head -1)
      random=$wallpapers/$random

      ${lib.strings.concatMapStringsSep "\n" (x: "swww img -o \"${x}\" --transition-type center \"$random\"") monitorList}
    '';
  };

  dual_monitor = writeShellApplication {
    name = "swww_dm";
    runtimeInputs = [swww];
    text = ''
      wallpapers=${wallpapers}/dual
      # shellcheck disable=SC2012
      random=$(ls $wallpapers | shuf | head -1)
      random=$wallpapers/$random

      convert -crop 50%x100% "$random" /tmp/output.png

      swww img -o "DP-1" --transition-type center /tmp/output-1.png
      swww img -o "DP-3" --transition-type center /tmp/output-0.png
    '';
  };
in
  symlinkJoin {
    name = "SWWW Scripts";
    paths = [single_monitor dual_monitor];
  }
