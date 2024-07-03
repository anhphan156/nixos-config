{
  lib,
  config,
  ...
}: {
  options.cyanea.networking.ethernet.enable = lib.mkEnableOption "Enable static ip for ethernet port";
  config = lib.mkIf config.cyanea.networking.ethernet.enable {
    networking = {
			interfaces = {
				enp37s0 = {
					ipv4.addresses = [{
						address = "172.17.50.50";
						prefixLength = 16;
					}];
				};
			};
		};
  };
}
