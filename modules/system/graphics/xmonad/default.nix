{
	config,
	lib,
	...
}:
let
	cfg = config.cyanea.graphical;
in
{
	options.cyanea.graphical.xmonad.enable = lib.mkEnableOption "Enable Xmonad";

	config = lib.mkIf (cfg.gui && cfg.xmonad) {
		services.xserver.windowManager.xmonad = {

		};
	};
}
