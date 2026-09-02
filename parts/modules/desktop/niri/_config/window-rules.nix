[
  {
    matches = [ { app-id = ".*"; } ];
    geometry-corner-radius = 12;
    clip-to-geometry = true;
  }
  {
    matches = [ { app-id = "librewolf|steam"; } ];
    open-maximized = true;
  }
  {
    matches = [ { app-id = "kitty"; } ];
    opacity = 0.8;
    background-effect = {
      blur = true;
      xray = true;
      noise = 0.05;
      saturation = 3;
    };
  }
]
