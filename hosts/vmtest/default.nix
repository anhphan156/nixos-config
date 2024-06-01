{
  user,
  inputs,
  rootPath,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs user rootPath;};
  system = "x86_64-linux";
  modules = [
    (rootPath + /overlay)
    (rootPath + /modules)
    (rootPath + /packages)
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

      # Set your time zone.
      time.timeZone = "America/Toronto";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_CA.UTF-8";

      users.users."${user.name}" = {
        isNormalUser = true;
        initialPassword = "123456";
        extraGroups = ["wheel"];
        packages = with pkgs; [];
      };

      nix.settings.experimental-features = ["nix-command" "flakes"];

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
