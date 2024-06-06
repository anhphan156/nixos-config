{pkgs}:
let
	tmux = "${pkgs.tmux}/bin/tmux";
	gdb = "${pkgs.gdb}/bin/gdb";
in pkgs.writeShellScriptBin "gdbx" ''
  #!/usr/bin/env bash

  reg="$(${tmux} split-pane -vPF "#D" -l 5 "tail -f /dev/null")"
  ${tmux} last-pane
  memory="$(${tmux} split-pane -hPF "#D" -l 90 "tail -f /dev/null")"
  ${tmux} last-pane
  asm="$(${tmux} split-pane -vPF "#D" -l 12 "tail -f /dev/null")"
  ${tmux} last-pane

  memory_tty="$(${tmux} display-message -p -t "$memory" '#{pane_tty}')"
  asm_tty="$(${tmux} display-message -p -t "$asm" '#{pane_tty}')"
  reg_tty="$(${tmux} display-message -p -t "$reg" '#{pane_tty}')"

  ${gdb} -ex "dashboard assembly -output $asm_tty" -ex "dashboard -output $memory_tty" -ex "dashboard registers -output $reg_tty" "$@"
  ${tmux} kill-pane -t "$memory"
  ${tmux} kill-pane -t "$asm"
  ${tmux} kill-pane -t "$reg"
''
