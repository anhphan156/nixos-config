{
	lib,
	...
}: with lib; {
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 3;

	networking.hostName = "omega"; # Define your hostname.

	isOmega = enabled;
	gui = enabled;
	hyprland = enabled;
	tmux = enabled;
	keepassxc = enabled;
	vesktop = enabled;
	firefox = enabled;
	googlechrome = enabled;
	gaming = enabled;
	virtualization = enabled;
	water_reminder = enabled;
	obsidian = enabled;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
