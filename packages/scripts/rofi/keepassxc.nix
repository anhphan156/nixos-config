{
  dbpath ? "~/data/Security/Passwords2.kdbx",
  wallpapers,
  writeShellApplication,
  rofi,
  rofiConfig,
  libnotify,
  keepassxc,
  ...
}:
writeShellApplication {
  name = "keepassrofi";

  runtimeInputs = [rofi libnotify keepassxc];

  text = ''
    path=${dbpath}
    if [ ! -f $path ]; then
      notify-send "Keepassxc" "Database not found" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      exit 1
    fi

    if dbpass=$(rofi -dmenu -password -p "Password" -config ${rofiConfig}); then
      if entry=$(echo "$dbpass" | keepassxc-cli ls $path | rofi -dmenu -p "Clip"); then
        echo "$dbpass" | keepassxc-cli clip $path "$entry"
        notify-send "Keepassxc" "Clipboard cleared" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      else
        notify-send "Keepassxc" "Probably wrong password" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
      fi
    fi
  '';
}
