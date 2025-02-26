{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      ankacoder
      material-icons
      texlivePackages.typicons
    ];

    # enableDefaultPackages = true;
  };
}
