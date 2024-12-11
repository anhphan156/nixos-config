{
  pkgs,
  config,
  lib,
  ...
}: let
  laptop = config.cyanea.system.laptop;
  awesome = config.cyanea.graphical.awesome;
in {
  options = {
    cyanea.system.acpid.enable = lib.mkEnableOption "enable acpid";
  };

  config = lib.mkIf config.cyanea.system.acpid.enable {
    services.acpid = {
      enable = true;
      handlers = {
        ac-power = lib.mkIf (laptop.enable && awesome.enable) {
          action = ''
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
          event = "ac_adapter/*";
        };
        button-power = lib.mkIf (laptop.enable && awesome.enable) {
          action = ''
            p=$(echo $PATH | grep '/run/current-system/sw/bin')
            if [ -z $p ]; then
                PATH=$PATH:/run/current-system/sw/bin
            fi
            vals=($1)
            case ''${vals[1]} in
                PBTN)
                    ${pkgs.sudo}/bin/sudo -u backspace XDG_RUNTIME_DIR="/run/user/$(id -u backspace)" ${pkgs.awesome}/bin/awesome-client "awesome.emit_signal('acpi::power_button')"
                    ;;
            esac
          '';
          event = "button/power.*";
        };
      };
    };

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
  };
}
