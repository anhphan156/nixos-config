{
	config,
	lib,
	...
}:
{
	options.cyanea.system.bootloader.confLim = lib.mkOption {
		type = lib.types.int;
		default = 3;
		description = "Number of configuration in systemd bootloader";
	};

	config = {
		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.systemd-boot.configurationLimit = config.cyanea.system.bootloader.confLim;
	};
}
