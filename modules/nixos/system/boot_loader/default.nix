{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.cyanea.system.bootloader;
in {
  options.cyanea.system.bootloader = {
    confLim = lib.mkOption {
      type = lib.types.int;
      default = 3;
      description = "Number of configuration in systemd bootloader";
    };
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable bootloader";
    };
    plymouth.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.configurationLimit = config.cyanea.system.bootloader.confLim;

      consoleLogLevel = lib.mkDefault 0;
      kernelParams = lib.optionals cfg.plymouth.enable [
        "quite"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      initrd = lib.mkIf cfg.plymouth.enable {
        verbose = false;
        systemd.enable = true;
      };

      plymouth = lib.mkIf cfg.plymouth.enable {
        enable = true;
        theme = "rings";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = ["rings"];
          })
        ];
      };
    };
  };
}
