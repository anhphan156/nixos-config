{
pkgs,
user,
...
}:{
  environment.systemPackages = with pkgs; [
		gcc
		gdb
		valgrind
		(import (user.rootPath + /packages/user_scripts/gdb-tmux.nix) {inherit pkgs;})
	];
}
