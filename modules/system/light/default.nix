{
config,
lib,
pkgs,
user,
...
}:{
	options.light_control.enable = lib.mkEnableOption "Enable brightness control";
	config = lib.mkIf config.light_control.enable {
		programs.light.enable = true;
		environment.systemPackages = with pkgs; [
			brightnessctl
			acpilight
		];
		users.users."${user.name}" = {
			extraGroups = lib.mkAfter ["video"];
		};
	};
}
