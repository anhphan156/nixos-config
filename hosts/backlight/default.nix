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
    inputs.nixvim.nixosModules.nixvim
    inputs.home-manager.nixosModules.home-manager

    ({
      config,
      pkgs,
      lib,
      inputs,
      ...
    }: {
      imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 10;

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };

      nix.settings.auto-optimise-store = true;
      nix.settings.experimental-features = ["nix-command" "flakes"];

      networking.hostName = "backspace"; # Define your hostname.

      # Set your time zone.
      time.timeZone = "America/Toronto";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_CA.UTF-8";

      users.users."${user.name}" = {
        isNormalUser = true;
        description = "backspace";
        extraGroups = ["wheel"];
        packages = with pkgs; [];
      };

      isBacklight.enable = lib.mkForce true;
      gui.enable = lib.mkForce true;
      xsv.enable = lib.mkForce true;
      awesome.enable = lib.mkForce true;
      picom.enable = lib.mkForce true;
      rofi.enable = lib.mkForce true;
      laptop.enable = lib.mkForce true;
      music.enable = lib.mkForce true;
      discord.enable = lib.mkForce true;
      keepassxc.enable = lib.mkForce true;
      firefox.enable = lib.mkForce true;
      tmux.enable = lib.mkForce true;
      water_reminder.enable = lib.mkForce true;
      dvorak.enable = lib.mkForce true;
      light_control.enable = lib.mkForce true;
      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

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