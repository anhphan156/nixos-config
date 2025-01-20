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
  };

  config = lib.mkIf config.cyanea.services.ollama.enable {
    services.ollama = {
      enable = true;
      inherit (config.cyanea.services.ollama) acceleration;
    };
  };
}
