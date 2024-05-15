{ config, lib, ... }:
{
    options = {
        ncmpcpp.enable = lib.mkEnableOption "Enable ncmpcpp";
    };

    config = lib.mkIf config.ncmpcpp.enable {
        programs.ncmpcpp = {
            enable = true;
            mpdMusicDir = "/home/backspace/data/Music";
            settings = {
                "execute_on_song_change" = ''bash -c "awesome-client \"awesome.emit_signal('ncmpcpp::songchanged', '$(mpc --format "%title% by %artist%" current)'); awesome.emit_signal('music_player::set_title') \" "'';
                "autocenter_mode" = "yes";            
                "allow_for_physical_item_deletion" = "no";

                "visualizer_data_source" = "/tmp/mpd.fifo";
                "visualizer_output_name" = "Visualizer feed";
                "visualizer_in_stereo" = "yes";
                "visualizer_type" = "ellipse";
                "visualizer_fps" = "60";
                "visualizer_look" = "●●";
                "visualizer_color" = "47, 83, 119, 155, 191, 227, 221, 215, 209, 203, 197, 161";

                "song_list_format" = "  %f $R%a %l  ";
                "song_status_format"= "$7%t";
                "song_columns_list_format" = "(45)[white]{ar}(47)[blue]{t}";
                "song_library_format" = "{{%a - %t} (%b)}|{%f}";
                "song_window_title_format" = "{%a - }{%t}|{%f}";

                "current_item_prefix" = "$(yellow)$r";
                "current_item_suffix" = "$/r$(end)";
                "current_item_inactive_column_prefix" = "$(red)$r";
                "current_item_inactive_column_suffix" = "$/r$(end)";
                "selected_item_prefix" = "$1";

                "playlist_display_mode" = "columns";
                "browser_display_mode" = "classic";
                "centered_cursor" = "no";

                "progressbar_look" = "▂▂▂";
                "progressbar_elapsed_color" = "green:b";
                "progressbar_color" = "black:b";

                "header_visibility" = "no";
                "titles_visibility" = "no";
                "statusbar_visibility" = "no";
                "colors_enabled" = "yes";
                "volume_color" = "white";
            };
        };
    };
}
