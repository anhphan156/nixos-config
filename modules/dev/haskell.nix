{
  pkgs,
	lib,
	config,
  ...
}: {
	options.cyanea.dev.haskell.enable = lib.mkEnableOption "Enable haskell dev tools";
	config = lib.mkIf config.cyanea.dev.haskell.enable {
		environment.systemPackages = with pkgs; [
			ghc
		];
	};
}
