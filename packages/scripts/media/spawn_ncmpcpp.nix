{
  writeShellApplication,
  wrapDesktopItem,
  ...
}:
wrapDesktopItem {
  categories = [ "Audio" ];
} <| writeShellApplication {
  name = "Music";
  text = ''
    kitty --class kittymusic ncmpcpp
  '';
}
