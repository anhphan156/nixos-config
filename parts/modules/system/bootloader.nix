{
  flake.nixosModules.bootloader = {lib, ...}: {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.configurationLimit = 3;

      consoleLogLevel = lib.mkDefault 0;
      # kernelParams = lib.optionals cfg.plymouth.enable [
      #   "quite"
      #   "splash"
      #   "boot.shell_on_fail"
      #   "loglevel=3"
      #   "rd.systemd.show_status=false"
      #   "rd.udev.log_level=3"
      #   "udev.log_priority=3"
      # ];
      # initrd = lib.mkIf cfg.plymouth.enable {
      #   verbose = false;
      #   systemd.enable = true;
      # };
      #
      # plymouth = lib.mkIf cfg.plymouth.enable {
      #   enable = true;
      #   theme = "rings";
      #   themePackages = with pkgs; [
      #     # By default we would install all themes
      #     (adi1090x-plymouth-themes.override {
      #       selected_themes = ["rings"];
      #     })
      #   ];
      # };
    };
  };
}
