{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.shell = moduleWithSystem (
    { self', ... }: { config, ... }: {
      users.users."${config.username}".shell = self'.packages.zsh;
    }
  );

  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages.zsh =
        (inputs.wrappers.wrapperModules.zsh.apply {
          inherit pkgs;
          settings = {
            autocd = true;

            shellAliases = {
              "l" = "ls -la --color";
              "g" = "git";
              "v" = "nvim";
            };

            integrations = {
              starship = {
                enable = true;
                package = self'.packages.starship;
              };
              zoxide = {
                enable = true;
              };
            };

            completion = {
              enable = true;
              colors = true;
              extraCompletions = true;
              fuzzySearch = true;
            };

            autoSuggestions = {
              enable = true;
            };

            history = {
              file = "$HOME/.local/share/zsh/zsh_history";
            };

            env = {
              "export _ZO_EXCLUDE_DIRS" = "/nix/store/*";
              "export LS_COLORS" = "di=34:*.zip=31:*.tar=31:*.gz=31:*.xz=31:*.7z=31";
              "export EDITOR" = "nvim";
              "export MANPAGER" = "\"nvim +Man!\"";
              "export FZF_PATH" = "~/.local/share/zsh/";
            };
          };

          extraRC = ''
            eval "$(direnv hook zsh)"
            function y() {
              local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
              command yazi "$@" --cwd-file="$tmp"
              IFS= read -r -d ''' cwd < "$tmp"
              [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
              command rm -f -- "$tmp"
            }

            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'l:|=*'

            GREEN='\033[0;32m'
            RED='\033[0;31m'
            MAGENTA='\033[0;35m'
            NC='\033[0m'
            printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"

            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          '';
        }).wrapper;
    };
}
