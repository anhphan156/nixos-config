{
  config,
  lib,
  user,
  dotfilesPath,
	pkgs,
  ...
}: {
  options.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.eww.enable {
		environment.systemPackages = with pkgs; [
			eww
		];
    home-manager.users."${user.name}" = {config, ...}: {
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };
      xdg.configFile = {
        "eww/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/eww";
      };
    };
  };
}
