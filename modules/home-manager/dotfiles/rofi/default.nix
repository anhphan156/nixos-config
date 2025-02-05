{
  pkgs,
  config,
  ...
}: {
  dotfiles.rofi.background = "${pkgs.wallpapers}/single/firefly_zzz.jpg";
  home.packages = [pkgs.rofi-wayland];
  xdg.configFile."rofi/".source = config.dotfiles.rofi.config;
}
