{
  writeShellScript,
  stdenv,
  pkgs,
  lib,
  wallpapers,
  ...
}: let
  acPower = writeShellScript "ac-power" ''
    vals=($1)
    case ''${vals[3]} in
      00000000)
        ${pkgs.sudo}/bin/sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" ${pkgs.libnotify}/bin/notify-send "ACPI Events" "Laptop is not charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
        ;;
      00000001)
        ${pkgs.sudo}/bin/sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" ${pkgs.libnotify}/bin/notify-send "Woohoo" "Laptop is charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
        ;;
    esac
  '';

  buttonPower = writeShellScript "button-power" ''
    vals=($1)
    case ''${vals[1]} in
      PBTN)
        ${pkgs.sudo}/bin/sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" ${pkgs.libnotify}/bin/notify-send "haha" "hehe"
        ;;
    esac
  '';
in
  stdenv.mkDerivation {
    pname = "Hyprland ACPI Scripts";
    version = "1.0.0";
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin
      cp ${buttonPower} $out/bin/button-power
      cp ${acPower} $out/bin/ac-power
    '';
  }
