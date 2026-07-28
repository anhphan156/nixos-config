{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.zsh = moduleWithSystem (
    { self', ... }: { config, ... }: {
      # programs.zsh.enable = true;
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
              "lzg" = " lazygit";
              "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
              "exit" = " exit";
              "leet" = " nvim +Leet";
            };

            integrations = {
              starship = {
                enable = true;
                package = self'.packages.starship;
              };
            };

            completion = {
              enable = true;
              colors = true;
              caseInsensitive = true;
            };

            autoSuggestions = {
              enable = true;
            };

            history = {
              file = "$HOME/.local/share/zsh/zsh_history";
            };

            env = {
              ZSHZ_DATA = "$HOME/.local/share/zsh/.z";
            };
          };
          extraRC = ''
            GREEN='\033[0;32m'
            RED='\033[0;31m'
            MAGENTA='\033[0;35m'
            NC='\033[0m'
            printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
            source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
          '';
        }).wrapper;
    };
}
