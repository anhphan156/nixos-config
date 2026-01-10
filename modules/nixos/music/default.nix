{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options.cyanea.music.enable = lib.mkEnableOption "Enable mpd and ncmpcpp";

  config = lib.mkIf config.cyanea.music.enable {
    mpd = lib.enabled;
    ncmpcpp = lib.enabled;

    home-manager.users."${lib.user.name}".home.packages =
      lib.mkIf config.ncmpcpp.enable
      (with pkgs; [
        (callPackage (inputs.self + /packages/scripts/media/spawn_ncmpcpp.nix) {})
        (callPackage (inputs.self + /packages/scripts/media/music_retag.nix) {musicPath = lib.user.path.music;})
        (callPackage (inputs.self + /packages/scripts/media/yt-dlp_mp3.nix) {musicPath = lib.user.path.music;})
        mpc
      ]);
  };
}
