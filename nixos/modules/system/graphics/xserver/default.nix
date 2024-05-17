{ rootPath, pkgs, lib, user, config, ... }:
{
    options = {
        xsv.enable = lib.mkEnableOption "Enable Xserver";
    };

    config = lib.mkIf (config.xsv.enable && config.gui.enable) {

        home-manager.users."${user.name}".home.packages = with pkgs; [
            arandr
            xorg.xrandr
        ];

        services.xserver = {
            xkb.layout = "us";
            xkb.variant = "";
            enable = true;
            #videoDrivers = [ "nvidia" ];

            windowManager.awesome = lib.mkIf config.awesome.enable {
                enable = true;
                package = pkgs.awesome;
                luaModules = with pkgs.luaPackages; [
                    luarocks
                    luadbi-mysql
                ];
            };
        };
    };
}
