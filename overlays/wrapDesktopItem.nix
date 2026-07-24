_: prev: {
  wrapDesktopItem = desktopItemArgs: myDerivation: let
    name = prev.lib.getName myDerivation;
    desktopName =
      name
      |> prev.lib.strings.stringToCharacters
      |> prev.lib.concatMapStringsSep "" (x:
        if x == "_"
        then " "
        else x);
    desktopItem =
      prev.makeDesktopItem
      <| {
        inherit name desktopName;
        genericName = "Scripts";
        noDisplay = false;
        comment = "";
        icon = "";
        dbusActivatable = false;
        exec = "${myDerivation}/bin/${name}";
        # path = "";
        terminal = false;
        # actions.example = {
        #   name = "New Window";
        #   exec = "my-program --new-window";
        #   icon = "/some/icon";
        # };
        # mimeTypes = ["video/mp4"];
        categories = ["Utility"];
        # implements = ["org.my-program"];
        keywords = [name];
        startupNotify = false;
        startupWMClass = name;
        prefersNonDefaultGPU = false;
        # extraConfig.X-SomeExtension = "somevalue";
      }
      // desktopItemArgs;
  in
    prev.symlinkJoin {
      inherit name;
      paths = [myDerivation desktopItem];
    };
}
