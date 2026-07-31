{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.zsh = moduleWithSystem (
    { self', ... }: { config, ... }: {
      users.users."${config.constants.username}".shell = self'.packages.zsh;
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
              "mpv" = "mpv --vo=kitty --vo-kitty-use-shm=yes";
              "leet" = "nvim +Leet";
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
            };
          };

          extraRC = ''
            eval "$(direnv hook zsh)"

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
