{
  lib,
  config,
  ...
}: {
  options.cyanea.networking.firewall.enable = lib.mkEnableOption "Enable Firewall";
  config = lib.mkIf config.cyanea.networking.firewall.enable {
    networking.firewall = {
      enable = true;
      # allowedTCPPorts = [6931];
    };
  };
}
