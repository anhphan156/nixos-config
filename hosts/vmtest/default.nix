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

			boot.initrd.postDeviceCommands = lib.mkAfter ''
				mkdir /btrfs_tmp
				mkdir /btrfs_tmp/root
				mkdir /btrfs_tmp/old_roots
				mount -o subvol=/root /dev/mapper/crypted /btrfs_tmp/root

				if [[ -e /btrfs_tmp/root ]]; then
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

				btrfs subvolume create /btrfs_tmp/root
				cp -r /btrfs_tmp/old_roots /btrfs_tmp/root
				umount /btrfs_tmp/root
			'';

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

      services.openssh.enable = true;
      services.openssh.settings.PermitRootLogin = "no";
      services.openssh.settings.PasswordAuthentication = true;

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;

      system.stateVersion = "24.05";
    })
  ];
}
