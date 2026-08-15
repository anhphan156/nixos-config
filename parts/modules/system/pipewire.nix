{
  flake.modules.nixos.desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.users."${config.username}" = {
        extraGroups = lib.mkAfter [ "audio" ];
      };

      environment.systemPackages = with pkgs; [
        pavucontrol
      ];
    };
}
