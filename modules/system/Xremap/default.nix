{
  user,
  config,
  lib,
  ...
}: {

  options.cyanea.system.xremap.enable = lib.mkEnableOption "Enable Xremap";

  config = 
    {
      services.xremap.enable = lib.mkForce config.cyanea.system.xremap.enable;
    } //
    lib.mkIf config.cyanea.system.xremap.enable {
      services.xremap = {
        withWlroots = config.cyanea.graphical.hyprland.enable;
        userName = user.name;
        config = {
          modmap = [
            {
              name = "Key remap";
              remap = {
                CONTROL_L = "Esc";
                CAPSLOCK = "CONTROL_L";
              };
            }
          ];
        };
      };
    };
}
