{
  writeShellApplication,
  wl-clipboard,
  imagemagick,
  libnotify,
  rofi,
  rofiConfig,
  wallpapers,
  ...
}:
writeShellApplication {
  name = "TextImage";
  runtimeInputs = [wl-clipboard imagemagick libnotify rofi];
  text = ''
    # todo: use wc to get word count and use it to calculate font size and break threshold
    text_raw=$(rofi -dmenu -p "Enter text" -config ${rofiConfig})

    text=$(echo "$text_raw" | fold -s -w 13 | sed 's/^\ \(.*\)/\1/g')
    sign=${wallpapers}/templates/sign.png
    coord="255,100"

    out="/tmp/$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 20).png"

    magick "$sign" -fill black -stroke black -font Anka/Coder-Regular -pointsize 30 -draw "text $coord '$text'" "$out"

    wl-copy -t image/png < "$out"

    notify-send "Screenshot" "Image is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png

    rm "$out"
  '';
}
