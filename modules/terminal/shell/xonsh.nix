{
  config,
  lib,
  ...
}: {
  options.cyanea.shell.xonsh = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.cyanea.shell.xonsh.enable {
    programs.xonsh = {
      enable = true;
      config = ''
        execx($(starship init xonsh))
      '';
    };
  };
}
