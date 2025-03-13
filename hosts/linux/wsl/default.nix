{
  lib,
  inputs,
  ...
}: let
  inherit (lib) enabled;
in {
  cyanea = {
    host.wsl = true;
    system = {
      bootloader.enable = false;
    };
    terminal = {
      tmux = enabled;
    };
  };

  home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/kitty";

  wsl.enable = true;
  wsl.defaultUser = lib.user.name;

  system.stateVersion = "24.05"; # Did you read the comment?
}
