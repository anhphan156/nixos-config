{
  flake.modules.nixos.dev = {
    programs.direnv = {
      enable = true;
      silent = true;
    };
  };
}
