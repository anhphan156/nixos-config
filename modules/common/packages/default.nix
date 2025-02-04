{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  guiCfg = config.cyanea.graphical.gui.enable;
in {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cmake
    gnumake
    curl
    file
    neovim
    cachix
    alejandra
  ];

  home-manager.users.${lib.user.name}.imports =
    lib.singleton "${inputs.self}/modules/home-manager/packages/console.nix"
    ++ lib.optional guiCfg "${inputs.self}/modules/home-manager/packages/gui.nix";
}
