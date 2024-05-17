{ config, pkgs, rootPath, user, ... }:
{
    imports = [
        ./ncmpcpp.nix
        ./mpd.nix
    ];

    home-manager.users."${user.name}".home.packages =
        if config.ncmpcpp.enable then
            with pkgs; [ 
                ( import (rootPath + /packages/user_scripts/spawn_ncmpcpp.nix) { inherit pkgs; } )
                ( import (rootPath + /packages/user_scripts/music_retag.nix) { inherit pkgs; } )
                mpc-cli
            ]
        else
            [];
}
