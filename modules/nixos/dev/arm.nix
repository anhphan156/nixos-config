{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cyanea.dev.arm.enable = lib.mkEnableOption "Enable Arm dev tools";
  config = lib.mkIf config.cyanea.dev.arm.enable {
    cyanea.dev.c = lib.enabled;
    environment.systemPackages = with pkgs; [
			pkgsCross.arm-embedded.buildPackages.gcc
			pkgsCross.armv7l-hf-multiplatform.buildPackages.gcc
			pkgsCross.armv7l-hf-multiplatform.glibc.static
    ];
  };
}
