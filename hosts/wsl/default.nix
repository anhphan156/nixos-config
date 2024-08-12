{lib, ...}: let
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
    dev = {
      c = enabled;
      rust = enabled;
    };
  };

  wsl.enable = true;
  wsl.defaultUser = "backspace";

  system.stateVersion = "24.05"; # Did you read the comment?
}
