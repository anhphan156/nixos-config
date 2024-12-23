{
  dbpath ? "~/data/Security/Passwords2.kdbx",
  myDotfiles,
  wallpapers,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "keepassrofi";

  text = ''
    path=${dbpath}
    if [ ! -f $path ]; then
      notify-send "Keepassxc" "Database not found" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      exit 1
    fi

    if dbpass=$(rofi -dmenu -password -p "Password" -config ${myDotfiles}/share/rofi/configPromptOnly.rasi); then
      if entry=$(echo "$dbpass" | keepassxc-cli ls $path | rofi -dmenu -p "Clip"); then
        echo "$dbpass" | keepassxc-cli clip $path "$entry"
        notify-send "Keepassxc" "Clipboard cleared" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      else
        notify-send "Keepassxc" "Probably wrong password" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      fi
    fi
  '';
}
