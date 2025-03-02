{
  pkgs,
  inputs,
  lib,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-darwin";
  nixpkgs.overlays = [
    inputs.nvim-config.overlays.default
  ];
  environment.systemPackages = with pkgs; [neovim cmatrix];

  users.users.${lib.user.name} = {
    home = "/Users/${lib.user.name}";
    description = lib.user.name;
  };

  system.stateVersion = 6;
}
