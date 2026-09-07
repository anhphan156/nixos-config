{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    services.udev.packages = [
      pkgs.yubikey-personalization
    ];
    # services.pcscd.enable = true;
    programs.yubikey-touch-detector = {
      enable = true;
      libnotify = true;
    };
    environment.systemPackages = with pkgs; [
      yubioath-flutter
      yubikey-manager
    ];
  };
}
