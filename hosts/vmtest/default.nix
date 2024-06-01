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

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;
			openssh.enable = lib.mkForce true;

      system.stateVersion = "24.05";
    })
  ];
}
