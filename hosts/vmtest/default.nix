{lib, ...}: let
  inherit (lib) enabled;
in {
  cyanea = {
    host.vmtest = true;
    desktopApp = {
      firefox = enabled;
    };
    system = {
      openssh = enabled;
      hostname = "vmtest";
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
      picom.enable = lib.mkOverride 49 false;
      sddm.autoLogin.enable = false;
    };
    dev = {
      c = enabled;
    };
    tools = {
      cybersec = enabled;
    };
    terminal.tmux = enabled;
  };

  services.xserver.xrandrHeads = [
    {
      output = "Virtual-1";
      primary = true;
      monitorConfig = ''
        option "PreferredMode" "1920x1080"
      '';
    }
  ];

  system.stateVersion = "24.05";
}
