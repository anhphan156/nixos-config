{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  laptop = config.cyanea.system.laptop;
  scripts = pkgs.callPackage (inputs.self + /packages/user_scripts/acpi/acpi_scripts.nix) {inherit lib;};
in {
  options = {
    cyanea.system.acpid.enable = lib.mkEnableOption "enable acpid";
  };

  config = lib.mkIf config.cyanea.system.acpid.enable {
    services.acpid = {
      enable = true;
      handlers = {
        ac-power = lib.mkIf laptop.enable {
          action = "${scripts}/bin/ac-power \"$1\"";
          event = "ac_adapter/*";
        };
        button-power = lib.mkIf laptop.enable {
          action = "${scripts}/bin/button-power \"$1\"";
          event = "button/power.*";
        };
      };
    };

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
  };
}
