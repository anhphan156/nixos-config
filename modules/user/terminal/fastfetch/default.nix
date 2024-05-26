{
  config,
  lib,
  user,
  ...
}: {
  config = {
    home-manager.users."${user.name}" = {config, ...}: {

      programs.zsh = {
        initExtra = lib.mkBefore ''
          fastfetch
				'';
			};

      xdg.configFile = {
        "fastfetch/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fastfetch";
      };
    };
  };
}
