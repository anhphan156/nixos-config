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

      systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
      services.openssh = {
        extraConfig = "AcceptEnv LANG LANGUAGE LC_*";
      };

      networking.wireless.enable = lib.mkForce false;
      tmux.enable = lib.mkForce true;
    })
  ];
}
