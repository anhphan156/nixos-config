{
  user,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
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
