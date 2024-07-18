{
  lib,
  user,
  ...
}:
with lib; {
  cyanea = {
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
      autorandr = enabled;
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
    };
    services = {
      water_reminder = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    dev = {
      c = enabled;
      rust = enabled;
    };
    music = enabled;
    virtualization = enabled;
  };

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
      ];
    };
  };

  users.users."${user.name}".initialPassword = "123";

  system.stateVersion = "23.11";
}
