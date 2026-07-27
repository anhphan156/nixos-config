{
  flake.nixosModules.pipewire = {
    pkgs,
    lib,
    config,
    ...
  }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."${config.constants.username}" = {
      extraGroups = lib.mkAfter ["audio"];
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
