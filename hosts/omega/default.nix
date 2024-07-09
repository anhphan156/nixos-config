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
        tripleMonitor = enabled;
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
    gaming = enabled;
    virtualization = enabled;
  };

  system.stateVersion = "23.11";
}
