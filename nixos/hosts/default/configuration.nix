# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
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

    services.libinput.touchpad.naturalScrolling = true;

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
        enable = true;
        #videoDrivers = [ "nvidia" ];

        displayManager = {
            sddm.enable = true;
            sddm.theme = "${import ../../packages/MarianArlt-sddm-sugar-dark { inherit pkgs; }}";
            defaultSession = "none+awesome";
            #autoLogin = {
            #    enable = true;
            #    user = "backspace";
            #};
        };

        windowManager.awesome = {
            enable = true;
            package = pkgs.awesome;
            luaModules = with pkgs.luaPackages; [
                luarocks
                luadbi-mysql
            ];
        };
    };

    programs = {
        zsh.enable = true;
        light.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.backspace = {
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
        inputs.lua-pam.packages."x86_64-linux".default
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtquickcontrols2
    ];

    fonts.fonts = with pkgs; [
        nerdfonts
        ankacoder
        material-icons
        texlivePackages.typicons
    ];

    environment.variables.EDITOR = "nvim";

    laptop.enable = lib.mkForce true;

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

}