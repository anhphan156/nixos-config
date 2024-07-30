{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cyanea.dev.avr.enable = lib.mkEnableOption "Enable AVR dev tools";
  config = lib.mkIf config.cyanea.dev.avr.enable {
    cyanea.dev.c = lib.enabled;
    environment.systemPackages = with pkgs; [
      avrdude
      pkgsCross.avr.buildPackages.gcc
      pkgsCross.avr.buildPackages.gdb
      # pkgsCross.avr.avrlibc
    ];
  };
}
