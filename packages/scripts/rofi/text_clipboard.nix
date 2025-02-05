{
  writeShellApplication,
  wrapDesktopItem,
  wl-clipboard,
  imagemagick,
  libnotify,
  rofi,
  rofiPromptConfig,
  rofiImgConfig,
  wallpapers,
  ...
}:
wrapDesktopItem {} <| writeShellApplication {
  name = "Text_Image";
  runtimeInputs = [wl-clipboard imagemagick libnotify rofi];
  text = ''
    # todo: use wc to get word count and use it to calculate font size and break threshold
    text_raw=$(rofi -dmenu -p "Enter text" -config ${rofiPromptConfig})

    path=${wallpapers}/templates
    sign=$(ls "$path" | while read -r img; do
      echo -en "''${img%.*}\0icon\x1f$path/$img\n";
    done | rofi -dmenu -p "Pick a template" -config ${rofiImgConfig})

    # filename: emote_id_rotation_x_y_break_fontsize.png
    rotation=$(echo "$sign" | awk -F '_' '{print $3}')
    coord="$(echo "$sign" | awk -F '_' '{print $4}'),$(echo "$sign" | awk -F '_' '{print $5}')"
    break=$(echo "$sign" | awk -F '_' '{print $6}')
    fontsize=$(echo "$sign" | awk -F '_' '{print $7}')

    text=$(echo "$text_raw" | fold -s -w "$break")
    out="/tmp/$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 20).png"
    img="$path/$sign.png"

    magick "$img" -fill black -stroke black -font Anka/Coder-Regular -pointsize "$fontsize" -draw "rotate $rotation text $coord '$text'" "$out"
    wl-copy -t image/png < "$out"
    notify-send "Screenshot" "Image is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png
    rm "$out"
  '';

  excludeShellChecks = ["SC2012"];
}
