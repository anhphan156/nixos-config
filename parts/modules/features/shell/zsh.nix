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
              "l" = " ls -la --color";
              "g" = "git";
              "v" = " nvim";
              "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
              "exit" = " exit";
              "leet" = " nvim +Leet";
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
              caseInsensitive = true;
              fuzzySearch = true;
            };

            autoSuggestions = {
              enable = true;
            };

            history = {
              file = "$HOME/.local/share/zsh/zsh_history";
            };

            env = {
              _ZO_DATA_DIR = "$HOME/.local/share/zsh/.z";
              _ZO_EXCLUDE_DIRS = "/nix/store/*";
            };
          };
          extraRC = ''
            eval "$(direnv hook zsh)"
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
