{
  pkgs,
  lib,
  ...
}: {
  cyanea = {
    desktopApp = {
      librewolf = lib.enabled;
    };
    graphical.gui = lib.enabled;
  };

  environment.systemPackages = with pkgs; [
    neovim
    cmatrix
    cowsay
  ];

  users.users.${lib.user.name} = {
    home = "/Users/${lib.user.name}";
    description = lib.user.name;
  };

  home-manager.users.${lib.user.name} = {
    home.homeDirectory = lib.mkForce "/Users/${lib.user.name}";
  };

  system.stateVersion = 6;
}
