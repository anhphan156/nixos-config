{lib, ...}:
with lib; {
  cyanea = {
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      keepassxc = enabled;
      rofi = enabled;
    };
    system = {
      hostname = "backlight";
      acpid = enabled;
      autorandr = enabled;
      laptop = enabled;
      light_control = enabled;
      xremap = enabled;
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
    };
    services = {
      water_reminder = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    music = enabled;
  };

  system.stateVersion = "23.11";
}
