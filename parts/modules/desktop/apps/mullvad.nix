{
  flake.modules.nixos.desktop =
    {
      config,
      pkgs,
      ...
    }:
    {
      services.mullvad-vpn = {
        enable = true;
        gui.enable = true;
      };

      preservation = {
        preserveAt."/persistence" = {
          directories = [
            "/etc/mullvad-vpn"
          ];

          users."${config.username}" = {
            directories = [
              ".config/Mullvad VPN"
            ];
          };
        };
      };

      environment.systemPackages = with pkgs; [
        (makeAutostartItem {
          name = "mullvad-vpn";
          package = mullvad-vpn;
        })
      ];
    };
}
