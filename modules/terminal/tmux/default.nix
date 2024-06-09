{
  user,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.terminal.tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.cyanea.terminal.tmux.enable {
    home-manager.users."${user.name}" = {
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        extraConfig = ''
        	set -g default-terminal "screen-256color"
					set -ga terminal-overrides ",*;Tc"
        '';

        plugins = with pkgs; [
          tmuxPlugins.nord
        ];
      };
    };
  };
}
