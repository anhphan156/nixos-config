{
  pkgs,
  config,
  ...
}: {
  dotfiles.rofi.background = "${pkgs.wallpapers}/single/firefly_zzz.jpg";
  xdg.configFile."rofi/".source = config.dotfiles.rofi.config;
}
