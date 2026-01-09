{
  lib,
  writeShellApplication,
  grim,
  slurp,
  wl-clipboard,
  gawk,
  imagemagick,
  libnotify,
  wallpapers,
  formats,
  mscreenshot,
  margin ? 10,
  radius ? 15,
  ...
}: let
  screenshot_config = (formats.json {}).generate "meme_screenshot_config.json" {
    sparkle = {
      stickers = [
        {
          path = "${wallpapers}/stickers/sparkle.png";
          pivot = 3;
          anchor = 3;
          scale = 1;
        }
      ];
    };
    yae = {
      stickers = [
        {
          path = "${wallpapers}/stickers/twosoyjaklumine.png";
          pivot = 3;
          anchor = 3;
          scale = 0.4;
        }
        {
          path = "${wallpapers}/stickers/twosoyjakyae.png";
          pivot = 2;
          anchor = 2;
          scale = 0.4;
        }
      ];
    };
  };
in
  writeShellApplication {
    name = "BorderedScreenshot";
    runtimeInputs = [grim slurp wl-clipboard gawk imagemagick libnotify];
    text = ''
      fn=$(echo -e "regular\nborder\ntwosoyjak\nsparkle" | rofi -dmenu -p "Enter a style")

           random_name=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 30)
           fg="/tmp/$random_name-fg.png"
           out="/tmp/$random_name-output.png"

           border(){
      		region=$(slurp -d)
           	dimension=$(echo "$region" | awk '{print $2}')
           	w=$(echo "$dimension" | cut -d'x' -f1)
           	h=$(echo "$dimension" | cut -d'x' -f2)

               m=${toString margin}
               r=${toString radius}

               grim -g "$region" -t png "$fg"

               magick -size "$((w+m*2))x$((h+m*2))" xc:none \
                 -fill plasma:#abcdef-#ef9889 -draw "roundrectangle 0,0 $((w+m*2)),$((h+m*2)) $r,$r" \
                 -fill "$fg" -draw "roundrectangle $((m+2)),$((m+2)) $((w+m-2)),$((h+m-2)) $r,$r" \
                 "$out"

               copy "$out"
               rm "$fg" "$out"
           }

           regular() {
      			region=$(slurp -d)
               grim -g "$region" -t png "$out"

               copy "$out"
               rm "$out"
           }

           twosoyjak() {
               MEME_SCREENSHOT_CONFIG=${screenshot_config} ${lib.getExe mscreenshot} -s yae -o "$out"

               copy "$out"
               rm "$fg" "$out"
           }

       sparkle() {
               MEME_SCREENSHOT_CONFIG=${screenshot_config} ${lib.getExe mscreenshot} -s sparkle -o "$out"
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
