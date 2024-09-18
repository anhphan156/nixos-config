{
  pkgs,
  user,
  lib,
  config,
  ...
}: {
  options.cyanea.dev.c.enable = lib.mkEnableOption "Enable C dev tools";
  config = lib.mkIf config.cyanea.dev.c.enable {
    environment.systemPackages = with pkgs; [
      gcc
      gdb
      valgrind
      (import (user.rootPath + /packages/user_scripts/gdb-tmux.nix) {inherit pkgs;})
    ];
  };
}
