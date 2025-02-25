{lib, ...}: {
  options = {
    cyanea.graphical.gui.enable = lib.mkEnableOption "Enable GUI";
    cyanea.host = let
      hostOption = lib.mkOption {
        type = lib.types.uniq lib.types.bool;
        default = false;
      };
    in
      lib.genAttrs [
        "omega"
        "backlight"
        "wsl"
        "vmtest"
      ] (_: hostOption);

    cyanea.keyboards.dvorak.enable = lib.mkEnableOption "Enable dvorak";
  };
}
