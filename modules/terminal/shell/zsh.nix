{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.lib.attrsets) filterAttrs mapAttrs' mapAttrsToList nameValuePair;

  rebuild-aliases = config.cyanea.host
    |> filterAttrs (_: y: y)
    |> (x: assert (x |> mapAttrsToList (k: _: k) |> builtins.length) <= 1; x)
    |> mapAttrs' (x: _: nameValuePair "rebuild" " sudo nixos-rebuild switch --flake ${config.cyanea.dotfilesPath}#${x}");
in {
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
          rebuild-aliases
          // {
            "v" = " nvim";
            "vim" = " nvim";
            "nvim" = " nvim";
            "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
          };
        oh-my-zsh = {
          enable = true;
          plugins = ["git" "z" "vi-mode"];
        };

        initExtra = lib.mkAfter ''
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
}
