#nix build .#nixosConfigurations.installer.config.system.build.isoImage
{
  user,
  inputs,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs user;};
  system = "x86_64-linux";
  modules = [
    (user.rootPath + /modules)
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

      users.users."${user.name}" = {
        initialPassword = "123";
      };

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
			openssh.enable = lib.mkForce true;	

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;
    })
  ];
}
