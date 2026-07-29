{ inputs, ... }: {

  flake.nixosModules.noctaliaGreeter = { config, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia-greeter = {
      enable = true;
      settings = {
        session.default = config.desktop.defaultSession;
        user.default = config.constants.username;

        appearance = {
          scheme = "Catppuccin";
          password_style = "random";
          hide_logo = false;
          theme_mode = "dark";
          corner_radius_scale = 12;
        };

        output = {
          name = config.desktop.greeterOutput;
        };

        keyboard = {
          layout = "us";
        };
      };
    };
  };
}
