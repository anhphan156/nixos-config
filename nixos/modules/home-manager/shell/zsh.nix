{
  programs.zsh ={
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {

    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" ];
      theme = "robbyrussell";
    };
  };
}
