{
  flake.modules.nixos.steam = {
    programs = {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
          # args = config.cyanea.gaming.gamescopeMonitor;
        };
      };
      gamemode.enable = true;
    };
  };
}
