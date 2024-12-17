{writeShellScriptBin, ...}: let
in
  writeShellScriptBin "tmux_code" ''
    #!/usr/bin/env bash

    SESSION_NAME="''${1:-Dot}"

     tmux kill-session -t $SESSION_NAME
     tmux new-session -d -s $SESSION_NAME
     tmux send-keys -t $SESSION_NAME " nvim" Enter
     tmux split-window -v
     tmux select-pane -t 0
     tmux resize-pane -D 6
     tmux attach -t $SESSION_NAME
  ''
