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
          monitorList = [
            "DP-3"
            "DP-1"
            "HDMI-A-1"
          ];
          resolutionList = [
            "3840x2160,-2560x0,1.5"
            "1920x1080@144,0x0,1,bitdepth,10"
            "1920x1080,5760x0,1"
          ];
          workspaceList = [[4 5 6] [1 2 3] [7]];
        };
      };
      sddm = {
        autoLogin.enable = false;
        defaultSession = "hyprland";
      }; # sddm
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
      # ollama = {
      #   enable = true;
      #   acceleration = "rocm";
      #   startupModel = "deepseek-r1:7b";
      #   rocmOverrideGfx = "10.3.0";
      # };
    };
    shell = {
      xonsh = enabled;
    };
    dev = {
      c = enabled;
      # rust = enabled;
    };
    virtualization = {
      libvirt = enabled;
      docker = enabled;
    };
    music = {
      enable = true;
      rpc = enabled;
    };
    gaming = {
      enable = true;
      gamescopeMonitor = [
        "-O DP-1"
        "-W 1920"
        "-H 1080"
      ];
      driver = ["amdgpu"];
    };
  };

  nixpkgs.overlays = [
    (_: prev: {
      myDotfiles = prev.myDotfiles.override {
        topBarWidth = "135%";
      };
    })
  ];

  system.stateVersion = "23.11";
}
