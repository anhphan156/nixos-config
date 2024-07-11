{
  lib,
  user,
  ...
}: {
  options = {
    cyanea.graphical.gui.enable = lib.mkEnableOption "Enable GUI";
    cyanea.user = {
      dotfilesPath = lib.mkOption {
        description = "Path to this project in string";
        type = lib.types.str;
        readOnly = true;
        default = "/home/${user.name}/dotfiles";
      };
    };
    cyanea.keyboards.dvorak.enable = lib.mkEnableOption "Enable xserver dvorak";
  };
}
