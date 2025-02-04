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
    fn=$(echo -e "regular\nborder\ntwosoyjak\ntwosoyjakscaled" | rofi -dmenu -p "Enter a style")
    region=$(slurp -d)

    dimension=$(echo "$region" | awk '{print $2}')
    w=$(echo "$dimension" | cut -d'x' -f1)
    h=$(echo "$dimension" | cut -d'x' -f2)

    random_name=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 30)
    fg="/tmp/$random_name-fg.png"
    out="/tmp/$random_name-output.png"

    border(){
        m=${builtins.toString margin}
        r=${builtins.toString radius}

        grim -g "$region" -t png "$fg"

        magick -size "$((w+m*2))x$((h+m*2))" xc:none \
          -fill plasma:#abcdef-#ef9889 -draw "roundrectangle 0,0 $((w+m*2)),$((h+m*2)) $r,$r" \
          -fill "$fg" -draw "roundrectangle $((m+2)),$((m+2)) $((w+m-2)),$((h+m-2)) $r,$r" \
          "$out"

        copy "$out"
        rm "$fg" "$out"
    }

    regular() {
        grim -g "$region" -t png "$out"

        copy "$out"
        rm "$out"
    }

    twosoyjak() {
        grim -g "$region" -t png "$fg"
        magick -size "$((w))x$((h))" xc:none \
          "$fg" -composite \
          "${wallpapers}/stickers/twosoyjaklumine.png" -geometry "+0+$((h-750))" -composite \
          "${wallpapers}/stickers/twosoyjakyae.png" -geometry "+$((w-500))+$((h-750))" -composite \
          "$out"

        copy "$out"
        rm "$fg" "$out"
    }

    twosoyjakscaled() {
        grim -g "$region" -t png "$fg"

        sticker_w=$((800*w/1920))
        sticker_h=$((750*sticker_w/500))

        magick -size "$((w))x$((h))" xc:none \
          "$fg" -composite \
          \( "${wallpapers}/stickers/twosoyjaklumine.png" -scale "$((sticker_w))x$((sticker_h))" \) -geometry "+0+$((h-sticker_h))" -composite \
          \( "${wallpapers}/stickers/twosoyjakyae.png" -scale "$((sticker_w))x$((sticker_h))" \) -geometry "+$((w-sticker_w))+$((h-sticker_h))" -composite \
          "$out"

        copy "$out"
        rm "$fg" "$out"
    }

    copy() {
        wl-copy -t image/png < "$out"
        notify-send "Screenshot" "Screenshot is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png
    }

    $fn
  '';
}
