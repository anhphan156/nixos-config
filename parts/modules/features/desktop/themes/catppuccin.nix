{ inputs, ... }: {
  flake.nixosModules.catppuccin = {
    imports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";

      gtk = {
        icon = {
          enable = true;
        };
      };

      sddm.enable = false;
    };

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = false;
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "catppuccin-mocha-mauve-compact+rimless";
            };
          };
        }
      ];
    };
  };
}
