{
	lib,
	...
}: with lib;
{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;

	networking.hostName = "backspace"; # Define your hostname.

	isBacklight = enabled;
	gui = enabled;
	xsv = enabled;
	awesome = enabled;
	picom = enabled;
	rofi = enabled;
	laptop = enabled;
	music = enabled;
	discord = enabled;
	keepassxc = enabled;
	firefox = enabled;
	tmux = enabled;
	water_reminder = enabled;
	dvorak = enabled;
	light_control = enabled;

	system.stateVersion = "23.11";
}
