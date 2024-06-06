{lib, ...}:
with lib; {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  cyanea = {
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      keepassxc = enabled;
      rofi = enabled;
    };
    system = {
      acpid = enabled;
      autorandr = enabled;
      laptop = enabled;
      light_control = enabled;
			hostname = "backlight";
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
