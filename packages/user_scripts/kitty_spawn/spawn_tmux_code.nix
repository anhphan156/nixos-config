{
  writeShellScriptBin,
  dotfilesPath,
  ...
}:
writeShellScriptBin "dotfiles" ''
  #!/usr/bin/env bash

  if [ ! -e "${dotfilesPath}" ]; then
    git clone git@github.com:anhphan156/dotfiles.git ${dotfilesPath}
  fi

  kitty --working-directory=${dotfilesPath} tmux_code
''
