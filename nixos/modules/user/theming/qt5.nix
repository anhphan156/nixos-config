{ user, pkgs, ... }:
{
    home-manager.users."${user.name}" = {
        qt.enable = true;
        qt.platformTheme = "gtk";
        qt.style.name = "adwaita-dark";
        qt.style.package = pkgs.adwaita-qt;
    };
}
