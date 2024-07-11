{lib, ...}:
with lib; {
  cyanea = {
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      googlechrome = enabled;
      keepassxc = enabled;
      obsidian = enabled;
    };
    system = {
      pipewire = enabled;
      xremap = enabled;
    };
    graphical = {
      gui = enabled;
      hyprland = {
        enable = mkForce true;
        monitor = [
          "DP-1,3840x2160,1920x0,1.5"
          "DP-3,1920x1080@144,0x0,1,bitdepth,10"
          "HDMI-A-1,1920x1080,5760x0,1"
        ];
      };
    };
    networking = {
      ethernet = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    services = {
      water_reminder = enabled;
      ratbagd = enabled;
    };
    dev = {
      c = enabled;
      rust = enabled;
    };
    music = enabled;
    gaming = enabled;
    virtualization = enabled;
  };

  system.stateVersion = "23.11";
}
