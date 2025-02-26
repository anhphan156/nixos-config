{pkgs, ...}: {
  home.packages = with pkgs; [
    eww
    myEwwScripts
  ];

  xdg.configFile = {
    "eww/".source = "${pkgs.myDotfiles}/share/eww";
  };
}
