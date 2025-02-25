{pkgs, ...}: {
  xdg.configFile = {
    "awesome/".source = "${pkgs.myDotfiles}/share/awesome";
  };
}
