{pkgs}:
pkgs.writeShellScriptBin "tmux_code" ''
   #!/usr/bin/env bash

	tmux kill-session -t Dev
  tmux new-session -d -s Dev
  tmux send-keys -t Dev " nvim" Enter
  tmux split-window -v
  tmux select-pane -t 0
  tmux resize-pane -D 6
  tmux attach -t Dev
''
