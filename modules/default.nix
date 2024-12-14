{
  lib,
  user,
  ...
}: {
  options = {
    cyanea.graphical.gui.enable = lib.mkEnableOption "Enable GUI";
    cyanea.host = let
      hostOption = lib.mkOption {
        type = lib.types.uniq lib.types.bool;
        default = false;
      };
    in {
      omega = hostOption;
      backlight = hostOption;
      wsl = hostOption;
      vmtest = hostOption;
    };
    cyanea.user = {
      dotfilesPath = lib.mkOption {
        description = "Path to this project in string";
        type = lib.types.str;
        readOnly = true;
        default = user.path.dotfiles;
      };
    };
    cyanea.keyboards.dvorak.enable = lib.mkEnableOption "Enable xserver dvorak";
  };
}
