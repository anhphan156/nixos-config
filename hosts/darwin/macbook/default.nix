{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # nixpkgs.hostPlatform = "x86_64-darwin";
  # nixpkgs.overlays = [
  #   inputs.nvim-config.overlays.default
  # ];

  users.users.${lib.user.name} = {
    home = "/Users/${lib.user.name}";
    description = lib.user.name;
  };

  home-manager.users.${lib.user.name} = {
    home.username = lib.mkForce lib.user.name;
    home.homeDirectory = lib.mkForce "/Users/${lib.user.name}";
  };

  system.stateVersion = 6;
}
