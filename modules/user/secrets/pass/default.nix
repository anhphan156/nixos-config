{
	config,
	lib,
	user,
	pkgs,
	...
}:{
	options.pass.enable = lib.mkEnableOption "Enable password-store";

	config = lib.mkIf config.pass.enable {
		home-manager.users."${user.name}" = {
			programs.password-store = {
				enable = true;
			};
		};
	};
}
