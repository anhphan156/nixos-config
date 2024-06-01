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

        plugins = with pkgs; [
          tmuxPlugins.nord
        ];
      };
    };
  };
}
