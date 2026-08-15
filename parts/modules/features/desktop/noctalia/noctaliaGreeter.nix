{ inputs, ... }: {

  flake.modules.nixos.noctaliaGreeter = { config, lib, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    options.greeterOutput = lib.mkOption {
      type = lib.types.str;
      description = "Default monitor for greeter";
    };

    config = {
      programs.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "niri";
          user.default = config.username;

          appearance = {
            scheme = "Catppuccin";
            password_style = "random";
            hide_logo = false;
            theme_mode = "dark";
            corner_radius_scale = 12;
          };

          output = {
            name = config.greeterOutput;
          };

          keyboard = {
            layout = "us";
          };
        };
      };
    };
  };
}
