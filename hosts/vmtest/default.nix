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

      services.openssh.enable = true;
      services.openssh.settings.PermitRootLogin = "no";
      services.openssh.settings.PasswordAuthentication = true;

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;

      system.stateVersion = "24.05";
    })
  ];
}
