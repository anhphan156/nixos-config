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
        type = lib.types.str;
        readOnly = true;
        default = lib.user.path.dotfiles;
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
