{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovim
    cmatrix
  ];

  users.users.${lib.user.name} = {
    home = "/Users/${lib.user.name}";
    description = lib.user.name;
  };

  home-manager.users.${lib.user.name} = {
    imports = [
      "${inputs.self}/modules/home-manager/dotfiles/kitty"
    ];
    home.homeDirectory = lib.mkForce "/Users/${lib.user.name}";
  };

  system.stateVersion = 6;
}
