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
    # make a rofi config that can preview images
    text_raw=$(rofi -dmenu -p "Enter text" -config ${rofiConfig})

    # shellcheck disable=SC2012
    sign=$(ls "${wallpapers}/templates/" | rofi -dmenu -p "Pick a template")

    text=$(echo "$text_raw" | fold -s -w 13)
    img="${wallpapers}/templates/$sign"
    rotation=$(echo "$sign" | awk -F '_' '{print $3}')
    coord="$(echo "$sign" | awk -F '_' '{print $4}'),$(echo "''${sign%.*}" | awk -F '_' '{print $5}')"
    out="/tmp/$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 20).png"

    magick "$img" -fill black -stroke black -font Anka/Coder-Regular -pointsize 28 -draw "rotate $rotation text $coord '$text'" "$out"
    wl-copy -t image/png < "$out"
    notify-send "Screenshot" "Image is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png
    rm "$out"
  '';
}
