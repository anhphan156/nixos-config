{
  writeShellScriptBin,
  rofi-wayland,
  evince,
  libreoffice,
  myDotfiles,
  ...
}:
writeShellScriptBin "search_docs" ''
  #!/usr/bin/env bash

  arg=$(find ~ 2> /dev/null | ${rofi-wayland}/bin/rofi -i -dmenu -p "Select a document:" -config ${myDotfiles + /share/rofi/config1Col.rasi})

  filename=$(basename $arg)
  extension="''${filename##*.}"

  if [[ $extension == "pdf" ]]
  then
      program=${evince}/bin/evince
  elif [[ $extension == "docx" ]]
  then
      program=${libreoffice}/bin/libreoffice
  fi

  [[ $arg != "" ]] && $program $arg
''
