{
  user,
  config,
  ...
}: {
  services.xremap = {
    withWlroots = config.cyanea.graphical.hyprland.enable;
    userName = user.name;
    config = {
      modmap = [
        {
          name = "Key remap";
          remap = {
            CONTROL_L = "CAPSLOCK";
            CAPSLOCK = "CONTROL_L";
          };
        }
      ];
    };
  };
}
