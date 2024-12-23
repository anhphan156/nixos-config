{
  writeShellScript,
  stdenv,
  pkgs,
  lib,
  ...
}: let
  acPower = writeShellScript "ac-power" ''
    p=$(echo $PATH | grep '/run/current-system/sw/bin')
    if [ -z $p ]; then
        PATH=$PATH:/run/current-system/sw/bin
    fi
    vals=($1)
    case ''${vals[3]} in
        00000000)
            ${pkgs.sudo}/bin/sudo -u backspace XDG_RUNTIME_DIR="/run/user/$(id -u backspace)" ${pkgs.awesome}/bin/awesome-client "awesome.emit_signal('acpi::unplugged')"
            ;;
        00000001)
            ${pkgs.sudo}/bin/sudo -u backspace XDG_RUNTIME_DIR="/run/user/$(id -u backspace)" ${pkgs.awesome}/bin/awesome-client "awesome.emit_signal('acpi::plugged')"
            ;;
    esac
  '';

  buttonPower = writeShellScript "button-power" ''
    p=$(echo $PATH | grep '/run/current-system/sw/bin')
    if [ -z $p ]; then
        PATH=$PATH:/run/current-system/sw/bin
    fi
    vals=($1)
    case ''${vals[1]} in
        PBTN)
            ${pkgs.sudo}/bin/sudo -u ${lib.user.name} XDG_RUNTIME_DIR="/run/user/$(id -u ${lib.user.name})" ${pkgs.awesome}/bin/awesome-client "awesome.emit_signal('acpi::power_button')"
            ;;
    esac
  '';
in
  stdenv.mkDerivation {
    pname = "awesome-acpi-scripts";
    version = "1.0.0";
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin
      cp ${buttonPower} $out/bin/button-power
      cp ${acPower} $out/bin/ac-power
    '';
  }
