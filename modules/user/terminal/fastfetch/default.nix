{
  config,
  lib,
  user,
  ...
}: 
let
	fastfetch_path = "${config.dotfilesPath}/config/fastfetch";
in
{
  config = {
    home-manager.users."${user.name}" = {config, ...}: {
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
