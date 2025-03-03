{
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    cyanea.terminal.tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.cyanea.terminal.tmux.enable {
    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/tmux";
  };
}
