{
  lib,
  user,
  ...
}: {
  imports = [
    ./user
    ./system
  ];

  options = {
    gui.enable = lib.mkEnableOption "Enable GUI";
    isBacklight.enable = lib.mkEnableOption "Enable services only for backlight";
    isOmega.enable = lib.mkEnableOption "Enable services only for omega";
    dotfilesPath = lib.mkOption {
      description = "Path to this project in string";
      type = lib.types.str;
      readOnly = true;
      default = "/home/${user.name}/dotfiles";
    };
		dvorak.enable = lib.mkEnableOption "Enable xserver dvorak";
  };
}
