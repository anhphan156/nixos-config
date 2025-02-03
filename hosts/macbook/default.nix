{pkgs, ...}: {
  nixpkgs.hostPlatform = "x86_64-darwin";
  environment.systemPackages = with pkgs; [
    neovim
  ];
}
