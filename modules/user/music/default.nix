{
  config,
  pkgs,
  rootPath,
  user,
	lib,
  ...
}: {
  imports = [
    ./ncmpcpp.nix
    ./mpd.nix
  ];

	options.music.enable = lib.mkEnableOption "Enable mpd and ncmpcpp";

	config = lib.mkIf config.music.enable {
		pulseaudio.enable = lib.mkDefault true;
		mpd.enable = lib.mkForce true;
		ncmpcpp.enable = lib.mkForce true;

		home-manager.users."${user.name}".home.packages =
			if config.ncmpcpp.enable
			then
				with pkgs; [
					(import (rootPath + /packages/user_scripts/kitty_spawn/spawn_ncmpcpp.nix) {inherit pkgs;})
					(import (rootPath + /packages/user_scripts/music_retag.nix) {inherit pkgs;})
					mpc-cli
				]
			else [];
	};
}
