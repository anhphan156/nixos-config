{
  lib,
  ...
}:
let
  inherit (lib) enabled;
in {

  cyanea = {
    host.vmtest = true;
    system = {
      openssh = enabled;
      hostname = "vmtest";
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
    };
    dev = {
      c = enabled;
    };
    tools = {
      cybersec = enabled;
    };
    terminal.tmux = enabled;
  };

  system.stateVersion = "24.05";
}
