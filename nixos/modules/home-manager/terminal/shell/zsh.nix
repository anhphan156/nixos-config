{ config, ...} :
{
    programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;

        history.path = "${config.xdg.dataHome}/zsh/zsh_history";
        sessionVariables = {
            "ZSHZ_DATA" = "${config.xdg.dataHome}/zsh/.z";
        };

        shellAliases = {
            "rebuild" = " sudo nixos-rebuild switch --flake ~/dotfiles/nixos#default";
            "v" = " nvim";
            "vim" = " nvim";
            "nvim" = " nvim";
        };
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "z" "vi-mode" ];
            theme = "robbyrussell";
        };

        initExtra = ''
            bunnyfetch
            
            GREEN='\033[0;32m'
            RED='\033[0;31m'
            MAGENTA='\033[0;35m'
            NC='\033[0m'
            printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
        '';
    };

    #programs.oh-my-posh = {
    #    enable = true;
    #    useTheme = "spaceship";
    #};
}
