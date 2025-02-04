{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.terminal.tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.cyanea.terminal.tmux.enable {
    home-manager.users."${lib.user.name}" = {
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        extraConfig = ''
          set-option -g default-terminal "tmux-256color"
          set-option -ga update-environment TERM
          set-option -ga update-environment TERM_PROGRAM
          set-option -g allow-passthrough on
        '';

        plugins = with pkgs; [
          tmuxPlugins.nord
        ];
      };
    };
  };
}
