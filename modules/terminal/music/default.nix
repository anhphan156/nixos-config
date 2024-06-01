{
  config,
  pkgs,
  user,
  lib,
  ...
}: {
  imports = [
    ./ncmpcpp.nix
    ./mpd.nix
  ];

  options.cyanea.music.enable = lib.mkEnableOption "Enable mpd and ncmpcpp";

  config = lib.mkIf config.cyanea.music.enable {
    cyanea.system.pulseaudio.enable = lib.mkDefault true;
    mpd = lib.enabled;
    ncmpcpp = lib.enabled;

    home-manager.users."${user.name}".home.packages =
      if config.ncmpcpp.enable
      then
        with pkgs; [
          (import (user.rootPath + /packages/user_scripts/kitty_spawn/spawn_ncmpcpp.nix) {inherit pkgs;})
          (import (user.rootPath + /packages/user_scripts/music_retag.nix) {inherit pkgs;})
          mpc-cli
        ]
      else [];
  };
}
