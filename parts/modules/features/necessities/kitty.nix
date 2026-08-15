{
  moduleWithSystem,
  inputs,
  ...
}:
{
  flake.modules.nixos.desktop = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [
        self'.packages.kitty
      ];
    }
  );
  perSystem = { pkgs, ... }: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        settings = {
          # Fonts
          font_family = "AnkaCoder-r";
          italic_font = "AnkaCoder-i";
          bold_font = "AnkaCoder-b";
          bold_italic_font = "AnkaCoder-bi";
          font_size = 15.0;

          # Cursor
          cursor_shape = "underline";
          cursor_blink_interval = 0;
          cursor_trail = 1;

          copy_on_select = "yes";
          shell_integration = "no-cursor";

          # Window
          remember_window_size = "no";
          initial_window_width = 1050;
          initial_window_height = 600;
          window_border_width = 0;
          window_padding_width = 15.0;
          confirm_os_window_close = 0;
        };
      }).wrapper;
  };
}
