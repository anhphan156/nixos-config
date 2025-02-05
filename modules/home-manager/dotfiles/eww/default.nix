{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    eww
    inputs.dotfiles.packages.${pkgs.system}.eww-scripts
  ];

  xdg.configFile = {
    "eww/".source = "${pkgs.myDotfiles}/share/eww";
  };
}
