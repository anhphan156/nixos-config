{
  writeShellApplication,
  wrapDesktopItem,
  rofi,
  rofiConfig,
  evince,
  libreoffice,
  fd,
  location ? "~",
  ...
}:
wrapDesktopItem {
  categories = ["Office"];
}
<| writeShellApplication {
  name = "Search_Documents";
  runtimeInputs = [rofi evince libreoffice fd];
  text = ''
    set +o pipefail

    arg=$(fd -e pdf . ${location} | rofi -i -dmenu -p "Select a document:" -config ${rofiConfig})

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
