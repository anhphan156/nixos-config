{
  programs.zsh ={
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
        "rebuild" = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#default";
        "v" = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "vi-mode" ];
      theme = "robbyrussell";
    };

    dotDir = ".config/zsh/";
    history.path = ".config/zsh/zsh_history";
    initExtra = ''
        neofetch
        
        GREEN='\033[0;32m'
        RED='\033[0;31m'
        MAGENTA='\033[0;35m'
        NC='\033[0m'
        printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
    '';
  };
}
