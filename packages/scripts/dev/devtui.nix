{
  writeShellApplication,
  tmux_code,
  basePath ? "~",
  fzf,
  ...
}:
writeShellApplication {
  name = "devtui";
  runtimeInputs = [fzf tmux_code];
  text = ''
    base=${basePath}
    if dir=$(ls $base | fzf --preview "ls $base/{}"); then
    	cd $base/"$dir"
    	tmux_code "$dir"
    fi
  '';
  excludeShellChecks = ["SC2012"];
}
