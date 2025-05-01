{
  config,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting = lib.enabled;
    autocd = true;

    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    sessionVariables = {
      "ZSHZ_DATA" = "${config.xdg.dataHome}/zsh/.z";
    };

    shellAliases = {
      "v" = " nvim";
      "vim" = " nvim";
      "nvim" = " nvim";
      "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
      "exit" = " exit";
      "oil" = " nvim +Oil";
      "leet" = " nvim +Leet";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z" "vi-mode"];
    };

    initContent = lib.mkAfter ''
      GREEN='\033[0;32m'
      RED='\033[0;31m'
      MAGENTA='\033[0;35m'
      NC='\033[0m'
      printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
    '';
  };
}
