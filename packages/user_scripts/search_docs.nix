{pkgs}:
pkgs.writeShellScriptBin "search_docs" ''
  #!/usr/bin/env bash

  arg=$(find ~ 2> /dev/null | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu -p "Select a document:")

  filename=$(basename $arg)
  extension="''${filename##*.}"

  if [[ $extension == "pdf" ]]
  then
      program=${pkgs.evince}/bin/evince
  elif [[ $extension == "docx" ]]
  then
      program=${pkgs.libreoffice}
  fi

  [[ $arg != "" ]] && $program $arg
''
