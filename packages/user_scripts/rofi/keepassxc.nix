{
  writeShellScript,
  dbpath ? "~/data/Security/Passwords2.kdbx",
  myDotfiles,
  wallpapers,
  ...
}:
writeShellScript "keepassrofi" ''
  path=${dbpath}
  if [ ! -f $path ]; then
    notify-send "Keepassxc" "Database not found" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
    exit 1
  fi

  dbpass=$(rofi -dmenu -password -p "Password" -config ${myDotfiles}/share/rofi/configPromptOnly.rasi)

  if [ $? -eq 0 ]; then
    entry=$(echo $dbpass | keepassxc-cli ls $path | rofi -dmenu -p "Clip")

    if [ $? -eq 0 ]; then
      echo $dbpass | keepassxc-cli clip $path $entry
      notify-send "Keepassxc" "Clipboard cleared" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
    else
      notify-send "Keepassxc" "Probably wrong password" -t 3000 --icon="${wallpapers}/icons/keepassdx.png"
    fi
  fi
''
