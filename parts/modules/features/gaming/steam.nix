{
  flake.nixosModules.steam = {
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
