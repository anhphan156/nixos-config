let
    mpd_path = "/home/backspace/.local/share/mpd";
in 
{
    services.mpd = {
        enable = true;
        network.startWhenNeeded = true;
        musicDirectory = /home/backspace/data/Music;
        extraConfig = ''
            bind_to_address		"any"

            playlist_directory		"${mpd_path}/playlists"
            db_file			"${mpd_path}/database"
            log_file			"${mpd_path}/log"
            pid_file			"${mpd_path}/pid"

            input {
                plugin "curl"
            }

            audio_output {
                type        "pulse"
                name        "My pulseaudio Device"
            #   device      "hw:0,0"    # optional
            #   mixer_type      "hardware"  # optional
            #   mixer_device    "default"   # optional
            #   mixer_control   "PCM"       # optional
            #   mixer_index "0"     # optional
            }
         
            audio_output {
                type        "fifo"
                name        "my_fifo"
                path        "/tmp/mpd.fifo"
                format      "44100:16:2"
            }
        '';
    };

    services.mpd-discord-rpc = {
        enable = true;
        settings = {
            hosts = [ "localhost:6600" ];
            format = {
                details = "$title";
                state = "By $artist";
            };
        };
    };
}
