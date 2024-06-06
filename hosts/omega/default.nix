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
      hyprland = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    services = {
      water_reminder = enabled;
    };
    gaming = enabled;
    virtualization = enabled;
  };

  system.stateVersion = "23.11";
}
