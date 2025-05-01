{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      ankacoder
      material-icons
      texlivePackages.typicons
    ];

    # enableDefaultPackages = true;
  };
}
