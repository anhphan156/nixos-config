{
  user,
  inputs,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs user;};
  system = "x86_64-linux";
  modules = [
    (user.rootPath + /overlay)
    (user.rootPath + /modules)
    (user.rootPath + /packages)
    inputs.home-manager.nixosModules.home-manager
    inputs.nixvim.nixosModules.nixvim
    inputs.disko.nixosModules.default
		inputs.impermanence.nixosModules.impermanence
    ({
      pkgs,
      lib,
      ...
    }: {
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

      environment.systemPackages = with pkgs; [
        disko
        git
        curl
        wget
        bat
      ];

			fileSystems."/persistence".neededForBoot = true;
			environment.persistence."/persistence" = {
				hideMounts = true;
				directories = [
					"/var/log"
					"/var/lib/bluetooth"
					"/var/lib/nixos"
					"/var/lib/systemd/coredump"
					"/etc/NetworkManager/system-connections"
					{ directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
				];
				files = [
					"/etc/machine-id"
				];
				users."${user.name}" = {
					directories = [
						{ directory = ".ssh"; mode = "0700"; }
					];
				};
			};

      services.openssh.enable = true;
      services.openssh.settings.PermitRootLogin = "no";
      services.openssh.settings.PasswordAuthentication = true;

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;

      system.stateVersion = "24.05";
    })
  ];
}
