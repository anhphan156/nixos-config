{writeShellScriptBin, ...}:
writeShellScriptBin "music" ''
  #!/usr/bin/env bash
  kitty --class kittymusic ncmpcpp
''
