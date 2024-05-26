{pkgs}:
pkgs.writeShellScriptBin "dotfiles" ''
  #!/usr/bin/env bash
  kitty --working-directory=~/dotfiles tmux_code
''
