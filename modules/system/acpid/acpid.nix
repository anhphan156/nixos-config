{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  laptop = config.cyanea.system.laptop;
  awesome = config.cyanea.graphical.awesome;

  hyprlandScripts = pkgs.callPackage (inputs.src + /packages/user_scripts/acpi/hyprland_scripts.nix) {inherit lib;};
  awesomeScripts = pkgs.callPackage (inputs.src + /packages/user_scripts/acpi/awesome_scripts.nix) {inherit lib;};

  scripts =
    if awesome.enable
    then awesomeScripts
    else hyprlandScripts;
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
