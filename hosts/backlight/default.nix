{
  lib,
  user,
  config,
  ...
}: let
  inherit (lib) enabled mkIf;
in {
  cyanea = {
    host.backlight = true;
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      keepassxc = enabled;
      rofi = enabled;
      obsidian = enabled;
    };
    system = {
      hostname = "backlight";
      acpid = enabled;
      # autorandr = enabled;
      laptop = enabled;
      pipewire = enabled;
      light_control = {
        enable = true;
        impermanence = enabled;
      };
      xremap = enabled;
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
      sddm.autoLogin.enable = false;
    };
    networking = {
      firewall = enabled;
    };
    services = {
      water_reminder = enabled;
      bluetooth = enabled;
      redshift = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    dev = {
      c = enabled;
      avr = enabled;
    };
    virtualization = {
      libvirt = enabled;
      docker = {
        enable = true;
        btrfs = true;
      };
    };
    music = enabled;
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
    users."${user.name}" = {
      directories = [
        "dotfiles"
        "data"
        ".ssh"
        ".mozilla"
        ".rustup"
        ".cargo"
        ".local/share/direnv"
        ".local/share/zsh"
        ".cache"
      ];
    };
  };

  users.users."${user.name}".initialPassword = "123";

  system.stateVersion = "23.11";
}
