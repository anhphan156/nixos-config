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
		pkgs, modulesPath, lib, ...
		}:{
			imports = [
				"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
			];

      users.users."${user.name}" = {
        isNormalUser = true;
				initialPassword = "123456";
        extraGroups = ["wheel"];
        packages = with pkgs; [];
      };

			nix.settings.experimental-features = [ "nix-command" "flakes" ];

			nixpkgs.hostPlatform = "x86_64-linux";

			environment.systemPackages = with pkgs; [
				disko
				git
				curl
				wget
			];

			systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
			networking.wireless.enable = lib.mkForce false;
		})
	];
}
