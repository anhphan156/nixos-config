{
  writeShellApplication,
  wrapDesktopItem,
  rofi,
  rofiConfig,
  evince,
  libreoffice,
  ...
}:
wrapDesktopItem {
  categories = [ "Office" ];
} <| writeShellApplication {
  name = "Search_Documents";
  runtimeInputs = [rofi evince libreoffice];
  text = ''
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

  passthru = {
    Type = "Application";
    Name = "Search Documents";
    Icon = "";
    Terminal = false;
    Categories = "";
  };
}
