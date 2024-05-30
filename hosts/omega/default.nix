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

    ({
      pkgs,
      lib,
      ...
    }: {
      imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 3;

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };

      nix.settings.auto-optimise-store = true;
      nix.settings.experimental-features = ["nix-command" "flakes"];

      networking.hostName = "omega"; # Define your hostname.

      # Set your time zone.
      time.timeZone = "America/Toronto";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_CA.UTF-8";

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."${user.name}" = {
        isNormalUser = true;
        description = "tbd";
        extraGroups = ["wheel"];
        packages = with pkgs; [];
      };

      isOmega.enable = lib.mkForce true;
      gui.enable = lib.mkForce true;
      hyprland.enable = lib.mkForce true;
      tmux.enable = lib.mkForce true;
      keepassxc.enable = lib.mkForce true;
      vesktop.enable = lib.mkForce true;
      firefox.enable = lib.mkForce true;
      googlechrome.enable = lib.mkForce true;
      gaming.enable = lib.mkForce true;
      virtualization.enable = lib.mkForce true;
      water_reminder.enable = lib.mkForce true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "23.11"; # Did you read the comment?
    })
  ];
}
