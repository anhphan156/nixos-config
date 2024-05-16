{ rootPath, pkgs, ... }:
{
    services.displayManager = {
        sddm.enable = true;
        sddm.theme = "${import (rootPath + /packages/MarianArlt-sddm-sugar-dark) { inherit pkgs; }}";
        defaultSession = "none+awesome";
        #autoLogin = {
        #    enable = true;
        #    user = "backspace";
        #};
    };
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
        enable = true;
        #videoDrivers = [ "nvidia" ];

        windowManager.awesome = {
            enable = true;
            package = pkgs.awesome;
            luaModules = with pkgs.luaPackages; [
                luarocks
                luadbi-mysql
            ];
        };
    };
}
