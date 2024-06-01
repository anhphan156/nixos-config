{lib, user, ...}: 
with lib; {
	imports = [
		./disk-config.nix
		./hardware-configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "vmtest"; # Define your hostname.

	users.users."${user.name}" = {
		initialPassword = "123";
	};

	fileSystems."/persistence".neededForBoot = true;
	environment.persistence."/persistence" = {
		hideMounts = true;
		directories = [
			"/var/log"
			"/var/lib/bluetooth"
			"/var/lib/nixos"
			"/var/lib/systemd/coredump"
			"/etc/NetworkManager/system-connections"
			{
				directory = "/var/lib/colord";
				user = "colord";
				group = "colord";
				mode = "u=rwx,g=rx,o=";
			}
		];
		files = [
			"/etc/machine-id"
		];
		users."${user.name}" = {
			directories = [
				"dotfiles"
				{
					directory = ".ssh";
					mode = "0700";
				}
			];
		};
	};

	tmux = enabled;
	openssh = enabled;

	system.stateVersion = "24.05";
}
