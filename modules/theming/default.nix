{ config, lib, ... }:
{
	options.cyanea.theme = lib.mkOption {
		description = "Path to this project in string";
		type = lib.types.str;
		default = "tokyonight";
	};
}
