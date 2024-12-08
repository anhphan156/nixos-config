{
  config,
  pkgs,
  user,
  lib,
  ...
}: {
  options.cyanea.music.enable = lib.mkEnableOption "Enable mpd and ncmpcpp";

  config = lib.mkIf config.cyanea.music.enable {
    mpd = lib.enabled;
    ncmpcpp = lib.enabled;

    home-manager.users."${user.name}".home.packages =
      lib.mkIf config.ncmpcpp.enable
      (with pkgs; [
        (callPackage (user.path.root + /packages/user_scripts/kitty_spawn/spawn_ncmpcpp.nix) {})
        (callPackage (user.path.root + /packages/user_scripts/music/music_retag.nix) {musicPath = user.path.music;})
        (callPackage (user.path.root + /packages/user_scripts/music/yt-dlp_mp3.nix) {musicPath = user.path.music;})
        mpc-cli
      ]);
  };
}
