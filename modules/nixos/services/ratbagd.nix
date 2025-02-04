{ lib, config, pkgs, ... }:{
	options.cyanea.services.ratbagd.enable = lib.mkEnableOption "Enable ratbagd";

	config = lib.mkIf config.cyanea.services.ratbagd.enable {
		services.ratbagd = lib.enabled;
	  home-manager = lib.install [ pkgs.piper ];
	};
}
