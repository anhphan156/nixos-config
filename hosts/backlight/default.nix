{lib, ...}:
with lib; {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  networking.hostName = "backspace"; # Define your hostname.

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
    };
    graphical = {
      gui = enabled;
      xsv = enabled;
      awesome = enabled;
      picom = enabled;
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
