{
  config,
  lib,
  ...
}: {
  options.cyanea.services.ollama = {
    enable = lib.mkEnableOption "Enable ollama";
    acceleration = lib.mkOption {
      description = "acceleration";
      type = lib.types.str;
    };
    rocmOverrideGfx = lib.mkOption {
      description = "rocmOverrideGfx";
      type = lib.types.str;
      default = "";
    };
    startupModel = lib.mkOption {
      description = "Startup Model";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.cyanea.services.ollama.enable {
    services.ollama = {
      enable = true;
      inherit (config.cyanea.services.ollama) acceleration rocmOverrideGfx;
      loadModels = [config.cyanea.services.ollama.startupModel];
    };
  };
}
