{ pkgs, awesome }:
{
    services.acpid = {
        enable = true;
        handlers = {
            ac-power = {
                action = ''
                    vals=($1)
                    case ''${vals[3]} in
                        00000000)
                            PATH=$PATH:/run/current-system/sw/bin/
                            ${pkgs.sudo}/bin/sudo -u backspace XDG_RUNTIME_DIR="/run/user/$(id -u backspace)" ${awesome}/bin/awesome-client "awesome.emit_signal('acpi::unplugged')"
                            ;;
                        00000001)
                            PATH=$PATH:/run/current-system/sw/bin/
                            ${pkgs.sudo}/bin/sudo -u backspace XDG_RUNTIME_DIR="/run/user/$(id -u backspace)" ${awesome}/bin/awesome-client "awesome.emit_signal('acpi::plugged')"
                            ;;
                    esac
                '';
                event = "ac_adapter/*";
            };
        };
    };
}
