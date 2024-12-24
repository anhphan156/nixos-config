{lib, ...}: let
  inherit (lib) enabled mkForce;
in {
  cyanea = {
    host.omega = true;
    desktopApp = {
      firefox = {
        enable = mkForce true;
        spacebar = enabled;
      };
      vesktop = enabled;
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
        monitor = {
          monitorList = ["DP-1" "DP-3" "HDMI-A-1"];
          resolutionList = ["3840x2160,1920x0,1.5" "1920x1080@144,0x0,1,bitdepth,10" "1920x1080,5760x0,1"];
          workspaceList = [[1 2 3] [4 5 6] [7]];
        };
      };
    };
    networking = {
      ethernet = enabled;
      wifi = enabled;
      firewall = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    services = {
      waterReminder = enabled;
      ratbagd = enabled;
    };
    dev = {
      c = enabled;
      # rust = enabled;
    };
    virtualization = {
      libvirt = enabled;
      docker = enabled;
    };
    music = enabled;
    gaming = enabled;
  };

  system.stateVersion = "23.11";
}
