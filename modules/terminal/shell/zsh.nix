{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.lib.attrsets) filterAttrs mapAttrs' mapAttrsToList nameValuePair;

  rebuildAliases = config.cyanea.host
    |> filterAttrs (_: y: y)
    |> (x: assert (x |> mapAttrsToList (k: _: k) |> builtins.length) <= 1; x)
    |> mapAttrs' (x: _: nameValuePair "rebuild" " sudo nixos-rebuild switch --flake ${lib.user.path.nixconf}#${x}");

  rofi = " rofi -config ${config.dotfiles.rofi.default}";
in {
  options.cyanea.shell.zsh = {
    enable = lib.mkOption {
      description = "Enable zsh";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cyanea.shell.zsh.enable {
    programs.zsh.enable = true;
    users.users."${lib.user.name}".shell = pkgs.zsh;

    home-manager.users."${lib.user.name}".imports = [
      ({config, ...}: {
        programs.zsh = {
          enable = true;
          syntaxHighlighting = lib.enabled;
          autocd = true;

          history.path = "${config.xdg.dataHome}/zsh/zsh_history";
          sessionVariables = {
            "ZSHZ_DATA" = "${config.xdg.dataHome}/zsh/.z";
          };

          shellAliases =
            rebuildAliases
            // {
              "v" = " nvim";
              "vim" = " nvim";
              "nvim" = " nvim";
              "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
              inherit rofi;
            };
          oh-my-zsh = {
            enable = true;
            plugins = ["git" "z" "vi-mode"];
          };

          initExtra = lib.mkAfter ''
            # Shell-GPT integration ZSH v0.2
            _sgpt_zsh() {
            if [[ -n "$BUFFER" ]]; then
                _sgpt_prev_cmd=$BUFFER
                BUFFER+="⌛"
                zle -I && zle redisplay
                BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
                zle end-of-line
            fi
            }
            zle -N _sgpt_zsh
            bindkey ^l _sgpt_zsh
            # Shell-GPT integration ZSH v0.2

            GREEN='\033[0;32m'
            RED='\033[0;31m'
            MAGENTA='\033[0;35m'
            NC='\033[0m'
            printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
          '';

          # plugins = [
          #   {
          #     name = "z";
          #     file = "zsh-z.plugin.zsh";
          #     src = pkgs.fetchFromGitHub {
          #       owner = "agkozak";
          #       repo = "zsh-z";
          #       rev = "afaf2965b41fdc6ca66066e09382726aa0b6aa04";
          #       sha256 = "1s23azd9hk57dgya0xrqh16jq1qbmm0n70x32mxg8b29ynks6w8n";
          #     };
          #   }
          # ];
        };
      })
    ];
  };
}
