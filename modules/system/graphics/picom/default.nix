{
  user,
  config,
  lib,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.picom.enable = lib.mkEnableOption "Enable picom";
  };

  config = lib.mkIf (cfg.gui.enable && cfg.picom.enable) {
    home-manager.users."${user.name}".services.picom = {
      enable = true;
      backend = "glx";

      settings = {
        blur-method = "dual_kawase";
        blur-strength = 5;
        blur-kern = "3x3box";
        blur-background = false;
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "class_g = 'slop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];

        shadow = true;
        shadow-radius = 20;
        shadow-offset-x = -5;
        shadow-offset-y = -5;
        shadow-exclude = [
          "name = 'Notification'"
          "class_g = 'Conky'"
          "class_g ?= 'Notify-osd'"
          "class_g = 'Cairo-clock'"
          "name = 'Awesome drawin'"
          "_GTK_FRAME_EXTENTS@:c"
        ];

        corner-radius = 14.0;
        rounded-corners-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];

        active-opacity = 0.85;
        inactive-opacity = 0.6;
        inactive-opacity-override = false;
        focus-exclude = ["class_g = 'Cairo-clock'"];
        opacity-rule = [
          "100:class_g = 'firefox'"
          "100:class_g = 'discord'"
        ];

        window-shader-fg-rule = [
          # "/home/backspace/dotfiles/config/picom/test.glsl:class_g = 'kittymusic'"
          "/home/backspace/dotfiles/config/picom/droplet.glsl:window_type = 'splash'"
        ];

        fading = true;
        fade-in-step = 0.03;
        fade-out-step = 0.03;

        dithered-present = false;
        vsync = true;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        glx-no-stencil = true;
        use-damage = true;
      };
    };
  };
}
