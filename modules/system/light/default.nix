{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
	imports = [
		./udevRule.nix
	];
  options.cyanea.system.light_control.enable = lib.mkEnableOption "Enable brightness control";
  config = lib.mkIf config.cyanea.system.light_control.enable {
    programs.light.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
      acpilight
    ];
    users.users."${user.name}" = {
      extraGroups = lib.mkAfter ["video"];
    };
  };
}
