{ user, inputs, rootPath, ... }:
inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs user rootPath; };
    system = "x86_64-linux";
    modules = [
        (rootPath + /overlay)
        (rootPath + /modules)
        (rootPath + /packages/user_packages)
        inputs.home-manager.nixosModules.home-manager

        ({ config, pkgs, lib, inputs, ... }:
        {
            imports =
                [ # Include the results of the hardware scan.
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

            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            networking.hostName = "backspace"; # Define your hostname.
            # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

            # Configure network proxy if necessary
            # networking.proxy.default = "http://user:password@proxy:port/";
            # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

            # Enable networking
            networking.networkmanager.enable = true;

            # Set your time zone.
            time.timeZone = "America/Toronto";

            # Select internationalisation properties.
            i18n.defaultLocale = "en_CA.UTF-8";

            programs = {
                zsh.enable = true;
                light.enable = true;
                dconf.enable = true;
            };

            # Define a user account. Don't forget to set a password with ‘passwd’.
            users.users."${user.name}" = {
                isNormalUser = true;
                description = "backspace";
                extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" ];
                packages = with pkgs; [];
                shell = pkgs.zsh;
            };

            # Allow unfree packages
            nixpkgs.config.allowUnfree = true;

            nixpkgs.config.pulseaudio = true;

            # List packages installed in system profile. To search, run:
            # $ nix search wget
            environment.systemPackages = with pkgs; [
            #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
                wget
                vim
                git
                curl
                cmake
                gnumake
                gcc
                brightnessctl
                acpilight
            ];

            fonts.fonts = with pkgs; [
                nerdfonts
                ankacoder
                material-icons
                texlivePackages.typicons
            ];

            environment.variables.EDITOR = "nvim";

            home-manager = {
                users."${user.name}".imports = [
                    ./home.nix
                ];
            };

            isBacklight.enable = lib.mkForce true;
            laptop.enable = lib.mkForce true;
            mpd.enable = lib.mkForce true;
            ncmpcpp.enable = lib.mkForce true;
            gui.enable = lib.mkForce true;
            awesome_config.enable = config.gui.enable;
            discord.enable = lib.mkForce true;
            keepassxc.enable = lib.mkForce true;
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
