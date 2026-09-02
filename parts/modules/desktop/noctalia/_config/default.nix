{ wallpapersDir, ... }: {
  config_version = 7;
  accessibility = {
    ui_scale = 1.3;
  };

  bar = {
    order = [ "widgets" ];

    widgets = {
      start = [ "workspaces" ];
      center = [
        "date"
        "cat"
        "clock"
      ];
      end = [
        "tray"
        "notifications"
        "clipboard"
        "network"
        "bluetooth"
        "volume"
        "brightness"
        "battery"
        "control-center"
        "session"
      ];
      position = "top";
      background_opacity = 0.5;
      margin_ends = 0;
      scale = 1.7;
      thickness = 40;
      radius = 0;
      radius_top_left = 0;
      radius_top_right = 0;
    };
  };

  desktop_widgets = {
    enabled = false;
    schema_version = 2;
    widget_order = [ ];

    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };

    widget = { };
  };

  nightlight = {
    enabled = true;
  };

  plugins = {
    enabled = [ "noctalia/bongocat" ];
  };

  widget.cat = {
    audio_spectrum = true;
    tappy_mode = true;
    type = "noctalia/bongocat:cat";
    use_mpris_filter = true;
  };

  location.address = "Toronto, Canada";

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
      launcher_placement = "attached";
      transparency_mode = "glass";
    };
    screen_corners = {
      enabled = false;
    };
    launcher.dmenu.entry = {
      cmd1 = {
        command = "fd --full-path $HOME -t f -e pdf | awk -F/ '{print $NF \"\\t\" $0}'";
        exec = "sh -c 'zathura \"$(printf \"%s\" \"{selection}\" | cut -f2)\"'";
        global = false;
        glyph = "terminal";
        label = "Open Documents";
        prefix = "doc";
      };
      cmd2 = {
        command = "fd --full-path $HOME/Games/vns -t f -e sh | awk -F/ '{print $NF \"\\t\" $0}'";
        exec = "sh -c '\"$(printf \"%s\" \"{selection}\" | cut -f2)\"'";
        global = false;
        glyph = "terminal";
        label = "Open Ren'Py Game";
        prefix = "vn";
      };
    };
  };

  theme = {
    mode = "dark";
    source = "wallpaper";
    wallpaper_scheme = "soft";
    templates.builtin_ids = [
      "gtk3"
      "gtk4"
    ];
  };

  keybinds = {
    up = [ "Shift+ISO_Left_Tab" ];
    down = [ "Tab" ];
    tab_next = [ "Down" ];
    tab_previous = [ "Up" ];
  };

  wallpaper = {
    directory = wallpapersDir;
    default = {
      path = "${wallpapersDir}/miku.png";
    };
  };
}
