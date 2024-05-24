{
		config,
		lib,
		user,
		...
} :{
	options.mako.enable = lib.mkEnableOption "Enable Mako";
	config = lib.mkIf config.mako.enable {
		home-manager.users.${user.name} = {
			services.mako = {
				enable = true;
				anchor = "top-right";
				borderRadius = 12;
				borderSize = 1;
			};
		};
	};
}
