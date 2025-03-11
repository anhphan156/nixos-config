#nix build .#nixosConfigurations.liveusb.config.system.build.isoImage
{
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
  ];

  users.users."${lib.user.name}".initialPassword = "123";

  hardware.enableAllFirmware = true;

  environment = {
    systemPackages = with pkgs; [
      disko
      arch-install-scripts
      (callPackage (inputs.self + /packages/scripts/pacmankey) {src = inputs.archlinux-keyring;})
    ];

    etc = {
      "pacman.d/mirrorlist" = {
        enable = true;
        source = pkgs.stdenvNoCC.mkDerivation {
          pname = "mirrorlist";
          version = "us-latest";
          src = inputs.archlinux-mirrorlist;

          unpackPhase = ''
            cat $src > mirrorlist
          '';
          patchPhase = ''
            sed -i 's/^.\(.*\)/\1/' mirrorlist
          '';
          installPhase = ''
            cat mirrorlist > $out
          '';
        };
      };

      "pacman.conf" = {
        enable = true;
        text = ''
          [options]
          ParallelDownloads = 5
          Architecture = auto
          HoldPkg = pacman glibc
          SigLevel = Required DatabaseOptional
          LocalFileSigLevel = Optional
          Color
          CheckSpace

          [core]
          Include = /etc/pacman.d/mirrorlist
          [extra]
          Include = /etc/pacman.d/mirrorlist
          [community]
          Include = /etc/pacman.d/mirrorlist
        '';
      };
    }; # etc
  };

  home-manager.users.${lib.user.name} = {
    home.file."disko-repo".source = inputs.disko;
  };

  systemd.services = {
    sshd.wantedBy = lib.mkForce ["multi-user.target"];

    "SetupPacman" = {
      description = "Create directory /var/lib/pacman";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.coreutils}/bin/mkdir -p /var/lib/pacman
        '';
      };
    };
  };

  networking.wireless.enable = lib.mkForce false;
  cyanea = {
    desktopApp = {
      librewolf = lib.enabled;
      firefox = lib.enabled;
    };
    graphical = {
      gui = lib.enabled;
      hyprland = lib.enabled;
    };
    terminal.tmux = lib.enabled;
    shell = {
      xonsh = lib.enabled;
    };
    system = {
      hostname = "NixosIntallerISO";
      xremap = lib.enabled;
      pipewire = lib.enabled;
    };
  };
}
