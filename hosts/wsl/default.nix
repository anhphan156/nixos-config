{
  lib,
  ...
}: let
  inherit (lib) enabled;
in {
  wsl.enable = true;
  wsl.defaultUser = "backspace";
  cyanea = {
    system = {
      bootloader.enable = false;
    };
    terminal = {
      tmux = enabled;
    };
    dev = {
      c = enabled;
      rust = enabled;
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
