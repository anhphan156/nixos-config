{
  writeShellScriptBin,
  libnotify,
  dotfilesPath,
  wallpapers,
  ...
}:
writeShellScriptBin "dotfiles" ''
  #!/usr/bin/env bash

  true

  if [ ! -e "${dotfilesPath}" ]; then
    ${libnotify}/bin/notify-send "Dotfiles" "Cloning into ${dotfilesPath}" -t 5000 --icon "${wallpapers}/icons/downloads_04.png"
    git clone git@github.com:anhphan156/dotfiles.git ${dotfilesPath}
  fi

  if [ $? -eq 0 ]; then
    kitty --working-directory=${dotfilesPath} tmux_code
  else
    ${libnotify}/bin/notify-send "Dotfiles" "Cloning failed" --icon"${wallpapers}/icons/downloads_04.png"
  fi

''
