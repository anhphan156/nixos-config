{
  lib,
  config,
  ...
}: let
  inherit (lib) enabled mkIf mkForce;
in {
  cyanea = {
    host.backlight = true;
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      keepassxc = enabled;
      obsidian = enabled;
    };
    system = {
      hostname = "backlight";
      acpid = enabled;
      # autorandr = enabled;
      laptop = enabled;
      pipewire = enabled;
      lightControl = {
        enable = true;
        impermanence = enabled;
      };
      xremap = enabled;
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
      hyprland = {
        enable = mkForce true;
        monitor = {
          monitorList = ["eDP-1" "HDMI-A-1"];
          resolutionList = ["1920x1080,0x0,1" "disable"];
          workspaceList = [[1 2 3 4]];
        };
      }; # hyprland
      sddm = {
        autoLogin.enable = false;
        defaultSession = "hyprland";
      }; # sddm
    }; # graphical
    networking = {
      firewall = enabled;
    };
    services = {
      waterReminder = enabled;
      bluetooth = enabled;
      redshift = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    dev = {
      c = enabled;
      haskell = enabled;
      avr = enabled;
    };
    virtualization = {
      libvirt = enabled;
      docker = {
        enable = true;
        btrfs = true;
      };
    };
    music = {
      enable = true;
      rpc = enabled;
    };
    gaming = {
      enable = true;
      gamescopeMonitor = [
        "-O eDP-1"
        "-W 1920"
        "-H 1080"
      ];
      nvidia.enable = true;
    };
  };

  services.xserver.xrandrHeads = mkIf (let
    cfg = config.cyanea.graphical;
  in
    cfg.xsv.enable && cfg.gui.enable) [
    {
      output = "HDMI-1";
      primary = false;
      monitorConfig = ''
        option "Disable" "true"
      '';
    }
    {
      output = "eDP-1";
      primary = true;
      monitorConfig = ''
        option "PreferredMode" "1920x1080"
      '';
    }
  ];

  fileSystems."/persistence".neededForBoot = true;
  environment.persistence."/persistence" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/alsa"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/libvirt"
      "/var/db/sudo/lectured"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
    users."${lib.user.name}" = {
      directories = [
        "data"
        ".ssh"
        ".mozilla"
        ".rustup"
        ".cargo"
        ".stack"
        ".steam"
        ".local/share/Steam"
        ".local/share/Sandbox Interactive GmbH"
        ".config/unity3d/Sandbox Interactive GmbH"
        ".local/share/direnv"
        ".local/share/zsh"
        ".config/vesktop"
        ".cache"
      ];
    };
  };

  users.users."${lib.user.name}".initialPassword = "123";

  system.stateVersion = "23.11";
}
