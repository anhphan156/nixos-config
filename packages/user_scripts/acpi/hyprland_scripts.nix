{
  writeShellApplication,
  symlinkJoin,
  sudo,
  libnotify,
  lib,
  wallpapers,
  ...
}: let
  acPower = writeShellApplication {
    name = "ac-power";
    runtimeInputs = [sudo libnotify];
    text = ''
      # shellcheck disable=SC2206
      vals=($1)
      case ''${vals[3]} in
        00000000)
          sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "ACPI Events" "Laptop is not charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
          ;;
        00000001)
          sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "Woohoo" "Laptop is charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
          ;;
      esac
    '';
  };

  buttonPower = writeShellApplication {
    name = "button-power";
    runtimeInputs = [sudo libnotify];
    text = ''
      # shellcheck disable=SC2206
      vals=($1)
      case ''${vals[1]} in
        PBTN)
          sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "haha" "hehe"
          ;;
      esac
    '';
  };
in
  symlinkJoin {
    name = "Hyprland ACPI Scripts";
    paths = [acPower buttonPower];
  }
