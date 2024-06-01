{ config, lib, ... }:
{
	options.openssh.enable = lib.mkEnableOption "Enable ssh";
	config = lib.mkIf config.openssh.enable {
		services.openssh.enable = true;
		services.openssh.settings.PermitRootLogin = "no";
		services.openssh.settings.PasswordAuthentication = true;
	};
}
