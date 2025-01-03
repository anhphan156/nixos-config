{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cyanea.shell.xonsh = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.cyanea.shell.xonsh.enable {
    users.users."${lib.user.name}".shell = pkgs.xonsh;
    programs.xonsh = {
      enable = true;
      config = ''
        execx($(starship init xonsh))
      '';
    };
  };
}
