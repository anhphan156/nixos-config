{
  lib,
  user,
  ...
}:
let
  inherit (lib) enabled;
in {

  cyanea = {
    system = {
      openssh = enabled;
      hostname = "vmtest";
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
    };
    dev = {
      c = enabled;
    };
    tools = {
      cybersec = enabled;
    };
    terminal.tmux = enabled;
  };
  users.users."${user.name}".initialPassword = "123";

  fileSystems."/persistence".neededForBoot = true;
  environment.persistence."/persistence" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
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
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };

  system.stateVersion = "24.05";
}
