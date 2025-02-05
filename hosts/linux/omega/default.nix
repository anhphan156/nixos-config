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
      googlechrome = enabled;
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
          resolutionList = let
            width_1 = 3840;
            width_2 = 1920;
            scale_1 = 1.5;
            offset_1 = -1 * width_1 / scale_1;
          in [
            "${toString width_1}x2160,${toString offset_1}x0,${toString scale_1}"
            "${toString width_2}x1080@144,0x0,1,bitdepth,10"
          ];
          workspaceList = [[4 5 6] [1 2 3]];
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
        dockPosition = "right center";
      };
    })
  ];

  system.stateVersion = "23.11";
}
