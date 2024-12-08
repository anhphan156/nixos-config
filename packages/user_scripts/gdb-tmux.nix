{
  writeShellScriptBin,
  tmux,
  gdb,
  ...
}: let
  tmux_bin = "${tmux}/bin/tmux";
  gdb_bin = "${gdb}/bin/gdb";
in
  writeShellScriptBin "gdbx" ''
      #!/usr/bin/env bash

      reg="$(${tmux_bin} split-pane -vPF "#D" -l 8 "tail -f /dev/null")"
      ${tmux_bin} last-pane
      memory="$(${tmux_bin} split-pane -hPF "#D" -l 90 "tail -f /dev/null")"
      ${tmux_bin} last-pane
      asm="$(${tmux_bin} split-pane -vPF "#D" -l 12 "tail -f /dev/null")"
      ${tmux_bin} last-pane

      memory_tty="$(${tmux_bin} display-message -p -t "$memory" '#{pane_tty}')"
      asm_tty="$(${tmux_bin} display-message -p -t "$asm" '#{pane_tty}')"
      reg_tty="$(${tmux_bin} display-message -p -t "$reg" '#{pane_tty}')"

      ${gdb_bin} -ex "dashboard assembly -output $asm_tty" -ex "dashboard -output $memory_tty" -ex "dashboard registers -output $reg_tty" "$1"
      ${tmux_bin} kill-pane -t "$memory"
      ${tmux_bin} kill-pane -t "$asm"
      ${tmux_bin} kill-pane -t "$reg"

    if [[ ! -z "$2" ]]; then
    	${tmux_bin} kill-window -t "$2"
    fi
  ''
