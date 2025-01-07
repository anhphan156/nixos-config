{
  writeShellApplication,
  grim,
  slurp,
  wl-clipboard,
  gawk,
  imagemagick,
  libnotify,
  wallpapers,
  margin ? 10,
  radius ? 15,
  ...
}:
writeShellApplication {
  name = "BorderedScreenshot";
  runtimeInputs = [grim slurp wl-clipboard gawk imagemagick libnotify];
  text = ''
    region=$(slurp -d)

    dimension=$(echo "$region" | awk '{print $2}')

    w=$(echo "$dimension" | cut -d'x' -f1)
    h=$(echo "$dimension" | cut -d'x' -f2)

    random_name=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 30)
    fg="/tmp/$random_name-fg.png"
    out="/tmp/$random_name-output.png"

    m=${builtins.toString margin}
    r=${builtins.toString radius}

    grim -g "$region" -t png "$fg"

    magick -size "$((w+m*2))x$((h+m*2))" xc:none \
      -fill plasma:#abcdef-#ef9889 -draw "roundrectangle 0,0 $((w+m*2)),$((h+m*2)) $r,$r" \
      -fill "$fg" -draw "roundrectangle $((m+2)),$((m+2)) $((w+m-2)),$((h+m-2)) $r,$r" \
      "$out"

    wl-copy -t image/png < "$out"

    notify-send "Screenshot" "Screenshot is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png

    # rm "$fg" "$out"
  '';
}
