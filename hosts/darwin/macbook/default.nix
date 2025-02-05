{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-darwin";
  # nixpkgs.overlays = [
  #   inputs.nvim-config.overlays.default
  # ];

  users.users."anhphan" = {
    home = "/Users/anhphan";
    description = "anhphan";
  };

  system.stateVersion = 6;
}
