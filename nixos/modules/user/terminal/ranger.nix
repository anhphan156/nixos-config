{ user, ... }:
{
    home-manager.users."${user.name}".programs.ranger = {
        enable = true;
        extraConfig = ''
            set preview_images true
            set preview_images_method kitty
            set show_hidden true
        '';
    };
}
