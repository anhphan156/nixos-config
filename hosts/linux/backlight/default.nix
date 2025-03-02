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
      firefox = enabled;
    };
    system = {
      # bootloader.plymouth = enabled;
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
      # ollama = {
      #   enable = true;
      #   acceleration = "cuda";
      #   startupModel = "llama3.2:1b";
      # };
    };
    terminal = {
      tmux = enabled;
    };
    shell = {
      xonsh = enabled;
      # shell-gpt = enabled;
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
      driver = ["nvidia"];
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
      "/var/lib/private/ollama"
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
        ".local/share/direnv"
        ".local/share/zsh"
        ".local/share/Anki2"
        ".local/share/mpd"
        ".local/share/nvim-custom"
        ".config/vesktop"
        ".config/unity3d/Sandbox Interactive GmbH"
        ".cache"
      ];
    };
  };

  users.users."${lib.user.name}".initialPassword = "123";

  system.stateVersion = "23.11";
}
