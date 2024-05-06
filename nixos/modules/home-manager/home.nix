{ config, pkgs, inputs, ... }:

{
    nixpkgs.config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
    };

    nixpkgs.overlays = [
        (final : prev : {
            ncmpcpp = prev.ncmpcpp.override {
                visualizerSupport = true;
            };
        })
        #(final : prev : {
        #    font-manager = prev.font-manager.overrideAttrs (old : {
        #        owner = "FontManager";
        #        repo = "font-manager";
        #        rev = "600f498946c3904064b4e4fdf96e5841f6a827e4";
        #        hash = "0qj14gbzjfba6kxs3n2jp19sidiiqw2rmsfwkz65hav2681c7rzf";
        #    });
        #})
    ];

    imports = [
        ( import ./packages.nix { inherit pkgs; } )
        ./shell/zsh.nix
        ./picom/picom.nix
        ./music/mpd.nix
        ./music/ncmpcpp.nix
        ./autorandr/autorandr.nix

        ( import ./browser/firefox.nix { inherit (inputs) firefox-addons; } )
    ];

    home.username = "backspace";
    home.homeDirectory = "/home/backspace";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

    home.file = {
        #".config/awesome/".source = ../../../config/awesome;
        ".config/ranger/".source = ../../../config/ranger;
        ".config/kitty/".source = ../../../config/kitty;
        ".config/rofi/".source = ../../../config/rofi;
        ".config/nvim/".source = ../../../config/nvim;
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/backspace/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.sessionPath = [
        "/home/backspace/dotfiles/bin/"
    ];

    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };

    systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};

    services.pasystray.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager = {
        enable = true;
    };

    programs.ripgrep.enable = true;

    programs.git = {
        enable = true;
        userName = "anh";
        userEmail = "anh.phan156@protonmail.com";
    };
}
