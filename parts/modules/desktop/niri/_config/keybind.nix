{
  lib,
  noctalia,
  screenshotScript,
  ...
}:
{
  "Mod+W".close-window = null;

  "Mod+H".focus-column-left = null;
  "Mod+L".focus-column-right = null;
  "Mod+Shift+H".move-column-left = null;
  "Mod+Shift+L".move-column-right = null;

  "Mod+J".focus-workspace-down = null;
  "Mod+K".focus-workspace-up = null;
  "Mod+Shift+J".move-column-to-workspace-down = null;
  "Mod+Shift+K".move-column-to-workspace-up = null;

  "Mod+U".focus-window-down = null;
  "Mod+I".focus-window-up = null;
  "Mod+Shift+U".move-window-down = null;
  "Mod+Shift+I".move-window-up = null;

  "Mod+bracketleft".consume-or-expel-window-left = null;
  "Mod+bracketright".consume-or-expel-window-right = null;

  "Mod+Minus".set-column-width = "-10%";
  "Mod+Equal".set-column-width = "+10%";

  "Mod+O".toggle-overview = null;
  "Mod+C".center-column = null;
  "Mod+M".maximize-column = null;
  "Mod+Shift+M".fullscreen-window = null;

  "Print".screenshot = null;
  "Mod+Print".spawn = [ "${lib.getExe screenshotScript}" ];

  "XF86AudioRaiseVolume".spawn = [
    "wpctl"
    "set-volume"
    "-l"
    "1"
    "@DEFAULT_AUDIO_SINK@"
    "5%+"
  ];
  "XF86AudioLowerVolume".spawn = [
    "wpctl"
    "set-volume"
    "@DEFAULT_AUDIO_SINK@"
    "5%-"
  ];
  "XF86AudioMute".spawn = [
    "wpctl"
    "set-mute"
    "@DEFAULT_AUDIO_SINK@"
    "toggle"
  ];

  "XF86MonBrightnessUp".spawn = [
    "brightnessctl"
    "-e4"
    "-n2"
    "set"
    "5%+"
  ];
  "XF86MonBrightnessDown".spawn = [
    "brightnessctl"
    "-e4"
    "-n2"
    "set"
    "5%-"
  ];

  "Alt+Space".spawn = [
    "${lib.getExe noctalia}"
    "msg"
    "panel-toggle"
    "launcher"
  ];
  "Mod+Return".spawn = [ "kitty" ];
}

// (builtins.listToAttrs (
  map
    (x: {
      name = "Mod+${toString x}";
      value = {
        focus-workspace = x;
      };
    })
    [
      1
      2
      3
      4
      5
    ]
))
// (builtins.listToAttrs (
  map
    (x: {
      name = "Mod+Shift+${toString x}";
      value = {
        move-column-to-workspace = x;
      };
    })
    [
      1
      2
      3
      4
      5
    ]
))
