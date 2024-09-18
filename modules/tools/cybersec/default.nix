{
config,
lib,
pkgs,
...
}: {
  options = {
    cyanea.tools.cybersec.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.cyanea.tools.cybersec.enable {
    home-manager = lib.install (with pkgs; [
      ghidra
      metasploit
    ]);
  };
}
