{
  config,
  lib,
  ...
}: {
  imports = [
    {
      services.xremap.enable = lib.mkDefault false;
    }
  ];

  options.cyanea.system.xremap.enable = lib.mkEnableOption "Enable Xremap";

  config = lib.mkIf config.cyanea.system.xremap.enable {
    services.xremap = {
      enable = lib.mkForce true;
      withWlroots = config.cyanea.graphical.hyprland.enable;
      userName = lib.user.name;
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
