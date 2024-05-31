{
lib,
config,
user,
pkgs,
...
}:{
	options.repo.dotfiles.enable = lib.mkEnableOption "Enable cloning dotfiles";
	config = lib.mkIf config.repo.dotfiles.enable {
		home-manager.users."${user.name}" = {config, lib, ...}:{
			home.activation = 
			let
				path = "${config.home.homeDirectory}/dotfiles";
				repo = "https://github.com/anhphan156/dotfiles";
			in
			{
				cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
					if [ ! -d "${path}" ]; then
						$DRY_RUN_CMD ${pkgs.git}/bin/git clone ${repo} "${path}"
					fi
				'';
			};
		};
	};
}
