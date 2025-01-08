{
  config,
  lib,
  ...
}: {
  options = {
    mpd.enable = lib.mkEnableOption "Enable mpd";
    cyanea.music.rpc.enable = lib.mkEnableOption "enable mpd rpc";
  };

  config = lib.mkIf config.mpd.enable {
    home-manager.users."${lib.user.name}".services = {
      mpd = {
        enable = true;
        network.startWhenNeeded = true;
        musicDirectory = lib.user.path.music;
        extraConfig = ''
          bind_to_address		"any"

          playlist_directory		"${lib.user.path.mpd}/playlists"
          db_file			"${lib.user.path.mpd}/database"
          log_file			"${lib.user.path.mpd}/log"
          pid_file			"${lib.user.path.mpd}/pid"

          input {
              plugin "curl"
          }

          #audio_output {
          #   type        "pulse"
          #   name        "My Pulseaudio Device"
          #   device      "hw:0,0"    # optional
          #   mixer_type      "hardware"  # optional
          #   mixer_device    "default"   # optional
          #   mixer_control   "PCM"       # optional
          #   mixer_index "0"     # optional
          #}

          audio_output {
              type        "pipewire"
              name        "My Pipewire Device"
          }

          audio_output {
              type        "fifo"
              name        "my_fifo"
              path        "/tmp/mpd.fifo"
              format      "44100:16:2"
          }
        '';
      };

      mpd-discord-rpc = {
        enable = true;
        settings = {
          hosts = ["localhost:6600"];
          format = {
            details = "$title";
            state = "By $artist";
          };
        };
      };
    };
  };
}
