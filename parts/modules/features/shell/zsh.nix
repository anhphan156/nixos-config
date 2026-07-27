{
  flake.nixosModules.zsh = {
    config,
    pkgs,
    ...
  }: {
    users.users."${config.constants.username}".shell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      histFile = "$HOME/.local/share/zsh/zsh_history";

      interactiveShellInit = ''
        export ZSHZ_DATA="$HOME/.local/share/zsh/.z";
      '';

      shellAliases = {
        "v" = " nvim";
        "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
        "exit" = " exit";
        "leet" = " nvim +Leet";
      };

      ohMyZsh = {
        enable = true;
        plugins = ["git" "z" "vi-mode"];
      };

      shellInit = ''
        GREEN='\033[0;32m'
        RED='\033[0;31m'
        MAGENTA='\033[0;35m'
        NC='\033[0m'
        printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
      '';
    };
  };
}
