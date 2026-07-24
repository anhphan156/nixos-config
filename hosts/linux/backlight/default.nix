{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) enabled mkIf mkForce;
in {
  cyanea = {
    host.backlight = true;
    desktopApp = {
      librewolf = enabled;
    };
    system = {
      # bootloader.plymouth = enabled;
      hostname = "backlight";
      # acpid = enabled;
      laptop = enabled;
      pipewire = enabled;
      lightControl = {
        enable = true;
        impermanence = enabled;
      };
    };
    graphical = {
      gui = enabled;
      hyprland = {
        enable = mkForce true;
        extraConfig = ''
          hl.monitor({
            output   = "eDP-1",
            mode     = "1920x1080",
            position = "0x0",
            scale    = "1.0",
          })

          for i = 1, 4 do
            hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
          end
        '';
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
      # bluetooth = enabled;
      redshift = enabled;
      # ollama = {
      #   enable = true;
      #   acceleration = "cuda";
      #   startupModel = "llama3.2:1b";
      # };
    };
    music = {
      enable = true;
      rpc = enabled;
    };
    gaming = {
      enable = true;
      faugus = enabled;
      protonplus = enabled;
      nvidia = enabled;
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
        "Downloads"
        ".ssh"
        ".cargo"
        ".steam"
        ".config/librewolf"
        ".config/faugus-launcher"
        ".local/share/Steam"
        ".local/share/direnv"
        ".local/share/zsh"
        ".local/share/Anki2"
        ".local/share/mpd"
        ".local/share/nvim-custom"
        ".local/share/applications"
        ".local/share/umu"
        ".cache"
      ];
    };
  };

  users.users."${lib.user.name}".initialPassword = "123";

  environment.systemPackages =
    builtins.map (game:
      pkgs.wrapDesktopItem {categories = ["Game"];} (pkgs.buildFHSEnv
        <| pkgs.appimageTools.defaultFhsEnvArgs
        // {
          name = game;
          runScript = "/home/${lib.user.name}/data/Games/${game}/${game}.sh";
        }))
    [
      "Eternum"
      "TheHeadmaster"
      "Ripples"
      "HaremHotel"
    ];

  system.stateVersion = "26.05";
}
