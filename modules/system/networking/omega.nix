{
  lib,
  config,
  ...
}: {
  options.cyanea.networking.ethernet.enable = lib.mkEnableOption "Enable static ip for ethernet port";
  config = {
    networking = {
      interfaces = {
				wlp39s0 = {
					ipv4.addresses = [
						{
							address = "10.0.0.69";
							prefixLength = 24;
						}
					];
				};
        enp37s0 = lib.mkIf config.cyanea.networking.ethernet.enable {
          ipv4.addresses = [
            {
              address = "172.17.50.50";
              prefixLength = 16;
            }
          ];
        };
      }; # interfaces
			defaultGateway = {
				address = "10.0.0.1";
				interface = "wlp39s0";
			}; # defaultGateway
    }; # networking
  };
}
