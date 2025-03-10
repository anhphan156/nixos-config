{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options.cyanea.dev.c.enable = lib.mkEnableOption "Enable C dev tools";
  config = lib.mkIf config.cyanea.dev.c.enable {
    environment.systemPackages = with pkgs; [
      gcc
      gdb
      valgrind
      man-pages
      (pkgs.callPackage (inputs.self + /packages/scripts/dev/gdb-tmux.nix) {})
    ];
  };
}
