{
  writeShellApplication,
  rofi,
  rofiConfig,
  evince,
  libreoffice,
  ...
}:
writeShellApplication {
  name = "search_docs";
  runtimeInputs = [rofi evince libreoffice];
  text = ''
    #!/usr/bin/env bash
    set +o pipefail

    arg=$(find ~ 2> /dev/null | rofi -i -dmenu -p "Select a document:" -config ${rofiConfig})

    filename=$(basename "$arg")
    extension="''${filename##*.}"

    if [[ $extension == "pdf" ]]
    then
        program=evince
    elif [[ $extension == "docx" ]]
    then
        program=libreoffice
    fi

    [[ "$arg" != "" ]] && $program "$arg"
  '';
}
