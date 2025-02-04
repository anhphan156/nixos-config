{
  writeShellApplication,
  symlinkJoin,
  sudo,
  libnotify,
  lib,
  wallpapers,
  gawk,
  awesome,
  dbus,
  ...
}: let
  acPower = writeShellApplication {
    name = "ac-power";
    runtimeInputs = [sudo libnotify gawk awesome dbus];
    text = ''
      session=$(loginctl list-sessions | awk '$4 == "seat0" {print $1}' | xargs loginctl show-session | grep Desktop | cut -d'=' -f2)

      vals=($1)
      case ''${vals[3]} in
        00000000)
          if [[ $session == "none+awesome" ]]; then
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::unplugged')"
          else
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "ACPI Events" "Laptop is not charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
          fi
          ;;

        00000001)
          if [[ $session == "none+awesome" ]]; then
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::plugged')"
          else
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "Woohoo" "Laptop is charging" -t 3000 --icon=${wallpapers}/icons/accubattery.png
          fi
          ;;
      esac
    '';

    excludeShellChecks = ["SC2206"];
  };

  buttonPower = writeShellApplication {
    name = "button-power";
    runtimeInputs = [sudo libnotify gawk awesome dbus];
    text = ''
      session=$(loginctl list-sessions | awk '$4 == "seat0" {print $1}' | xargs loginctl show-session | grep Desktop | cut -d'=' -f2)

      vals=($1)
      case ''${vals[1]} in
        PBTN)
          if [[ $session == "none+awesome" ]]; then
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::power_button')"
          else
            sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" notify-send "hehe" "haha" -t 3000
          fi
          ;;
      esac
    '';
    excludeShellChecks = ["SC2206"];
  };
in
  symlinkJoin {
    name = "Hyprland ACPI Scripts";
    paths = [acPower buttonPower];
  }
