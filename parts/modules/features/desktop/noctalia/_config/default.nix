{ wallpapersDir, ... }: {
  config_version = 7;
  accessibility = {
    ui_scale = 1.300000011920929;
  };

  bar = {
    order = [ "widgets" ];

    widgets = {
      margin_ends = 0;
      position = "left";
      scale = 1.7000000178813934;
      thickness = 40;
    };
  };

  desktop_widgets = {
    schema_version = 2;
    widget_order = [ ];

    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };

    widget = { };
  };

  dock = {
    enabled = false;
    position = "right";
    reserve_space = false;
    smart_auto_hide = true;
  };

  shell = {
    font_family = "Anka/Coder";
    setup_wizard_enabled = false;
    launch_apps_as_systemd_services = true; # launch apps as transient systemd services (needs Noctalia to be a user unit)
    panel = {
      launcher_position = "auto";
    };
    screen_corners = {
      enabled = true;
    };
    keybinds = {
      up = [ "Shift+ISO_Left_Tab" ];
      down = [ "Tab" ];
      tab_next = [ "Down" ];
      tab_previous = [ "Up" ];
    };
    launcher.dmenu.entry = {
      cmd1 = {
        command = "fd --full-path $HOME -t f -e pdf";
        exec = "zathura \"$HOME/{selection}\"";
        global = false;
        glyph = "terminal";
        label = "Open Documents";
        prefix = "doc";
      };
      cmd2 = {
        command = "fd --full-path $HOME/Games/vns -t f -e sh";
        exec = "{selection}";
        global = false;
        glyph = "terminal";
        label = "Open Ren'Py Game";
        prefix = "vn";
      };
    };
  };

  theme = {
    builtin = "Catppuccin";
    mode = "dark";
    source = "builtin";
    wallpaper_scheme = "m3-content";
  };

  wallpaper = {
    directory = wallpapersDir;
    automation = {
      enabled = true;
      interval_seconds = 300;
    };
  };
}
