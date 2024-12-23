{
  writeShellApplication,
  symlinkJoin,
  sudo,
  awesome,
  lib,
  dbus,
  ...
}: let
  acPower = writeShellApplication {
    name = "ac-power";
    runtimeInputs = [dbus sudo awesome];
    text = ''
      # shellcheck disable=SC2206
      vals=($1)
      case ''${vals[3]} in
          00000000)
              sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::unplugged')"
              ;;
          00000001)
              sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::plugged')"
              ;;
      esac
    '';
  };

  buttonPower = writeShellApplication {
    name = "button-power";
    runtimeInputs = [dbus sudo awesome];
    text = ''
      # shellcheck disable=SC2206
      vals=($1)
      case ''${vals[1]} in
          PBTN)
              sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" awesome-client "awesome.emit_signal('acpi::power_button')"
              ;;
      esac
    '';
  };
in
  symlinkJoin {
    name = "AwesomeWM ACPI Scripts";
    paths = [acPower buttonPower];
  }
