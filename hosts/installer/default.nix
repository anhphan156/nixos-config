#nix build .#nixosConfigurations.installer.config.system.build.isoImage
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
    (rootPath + /modules)
    inputs.home-manager.nixosModules.home-manager
    inputs.nixvim.nixosModules.nixvim
    ({
      pkgs,
      modulesPath,
      lib,
      ...
    }: {
      imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];

      networking.hostName = "NixosInstaller"; # Define your hostname.

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

      nixpkgs.hostPlatform = "x86_64-linux";
			nixpkgs.config.allowUnfree = true;
			hardware.enableAllFirmware = true;

      environment.systemPackages = with pkgs; [
        disko
        git
        curl
        wget
        bat
        inputs.alejandra.defaultPackage.${pkgs.system}
				nix-prefetch-git
      ];

      systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
      services.openssh = {
        extraConfig = "AcceptEnv LANG LANGUAGE LC_*";
      };

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;
    })
  ];
}