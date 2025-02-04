{pkgs, ...}: {
  imports = [
    ./fonts
  ];

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
}
