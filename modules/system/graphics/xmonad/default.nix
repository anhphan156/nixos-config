{
	config,
	lib,
	user,
	pkgs,
	...
}:
let
	cfg = config.cyanea.graphical;
in
{
	options.cyanea.graphical.xmonad.enable = lib.mkEnableOption "Enable Xmonad";

	config = lib.mkIf (cfg.gui.enable && cfg.xmonad.enable) {
		cyanea.graphical.xsv = lib.enabled;

		environment.systemPackages = with pkgs; [
			xterm dmenu
		];

		services.xserver.windowManager.xmonad = {
			enable = true;
			enableContribAndExtras = true;
			config = builtins.readFile (user.rootPath + /config/xmonad/xmonad.hs);
		};
	};
}
