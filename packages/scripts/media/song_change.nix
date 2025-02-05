{
  writeShellApplication,
  awesome,
  libnotify,
  gawk,
  wallpapers,
  ...
}:
writeShellApplication {
  name = "song_change";
  runtimeInputs = [awesome libnotify gawk];
  text = ''
    session=$(loginctl list-sessions | awk '$4 == "seat0" {print $1}' | xargs loginctl show-session | grep Desktop | cut -d'=' -f2)

    title=$(mpc --format "%title% by %artist%" current)

    if [[ $session == "none+awesome" ]]; then
      awesome-client "awesome.emit_signal('ncmpcpp::songchanged', '$title'); awesome.emit_signal('music_player::set_title')"
    fi

    notify-send "New Song Playing" "$title" -t 3000 --icon=${wallpapers}/icons/pi_music_player.png
  '';
}
