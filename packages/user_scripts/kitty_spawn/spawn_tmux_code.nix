{
  writeShellScriptBin,
  dotfilesPath,
  ...
}:
writeShellScriptBin "dotfiles" ''
  #!/usr/bin/env bash
  kitty --working-directory=${dotfilesPath} tmux_code
''
