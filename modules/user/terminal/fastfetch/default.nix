{
  config,
  lib,
  user,
  pkgs,
  ...
}: let
  fastfetch_path = "${config.dotfilesPath}/config/fastfetch";
in {
  config = {
    home-manager.users."${user.name}" = {config, ...}: {
			home.packages = with pkgs; [
				fastfetch
			];

      programs.zsh = {
        initExtra = lib.mkBefore ''
          fastfetch
        '';
      };

      xdg.configFile = {
        "fastfetch/".source = config.lib.file.mkOutOfStoreSymlink fastfetch_path;
      };
    };
  };
}
