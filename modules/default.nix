{
  lib,
  pkgs,
  inputs,
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
    cyanea = {
      dotfilesPath = lib.mkOption {
        description = "Path to this project in string";
        type = lib.types.path;
        readOnly = true;
        default =
          if lib.user.dev_mode
          then lib.user.path.dot
          else lib.user.path.root;
      };

      wallpapers = lib.mkOption {
        description = "Wallpapers";
        type = lib.types.package;
        readOnly = true;
        default = inputs.wallpapers.packages."${pkgs.system}".default;
      };
    };

    cyanea.keyboards.dvorak.enable = lib.mkEnableOption "Enable xserver dvorak";
  };
}
