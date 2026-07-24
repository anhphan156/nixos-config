{
  lib,
  specialArgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = specialArgs;
    users."${lib.user.name}" = {
      inputs,
      lib,
      config,
      pkgs,
      ...
    }: {
      imports = [
        inputs.dotfiles.nixosModules.default
      ];

      home.username = lib.user.name;
      home.homeDirectory = lib.mkDefault "/home/${lib.user.name}";

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "26.05"; # Please read the comment before changing.

      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/backspace/etc/profile.d/hm-session-vars.sh
      #
      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };

      #home.sessionPath = [
      #    "/home/backspace/dotfiles/bin/"
      #];

      programs = {
        home-manager.enable = true;

        zsh = {
          enable = true;
          syntaxHighlighting = lib.enabled;
          autocd = true;

          history.path = "${config.xdg.dataHome}/zsh/zsh_history";
          sessionVariables = {
            "ZSHZ_DATA" = "${config.xdg.dataHome}/zsh/.z";
          };

          shellAliases = {
            "v" = " nvim";
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
            fastfetch
            GREEN='\033[0;32m'
            RED='\033[0;31m'
            MAGENTA='\033[0;35m'
            NC='\033[0m'
            printf "''${GREEN}There is''${NC} ''${RED}no''${NC} ''${MAGENTA}place like''${NC} ''${RED}~/''${NC}\n"
          '';
        };

        fastfetch = {
          enable = true;
          settings = {
            "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
            logo = {
              source = "${pkgs.wallpapers}/fetch_logo/neofetch.jpg";
              height = 18;
            };
            display = {
              separator = "  ";
            };

            modules = [
              {
                type = "custom";
                format = "  コンピューター";
                outputColor = "red";
              }
              {
                type = "custom";
                format = "┌────────────────────────────────────────────────────┐";
                outputColor = "white";
              }
              {
                type = "os";
                key = "  ";
                keyColor = "red";
              }
              {
                type = "kernel";
                key = "  ";
                keyColor = "red";
              }
              {
                type = "packages";
                key = "  ";
                keyColor = "green";
              }
              {
                type = "display";
                key = "  󰹑";
                keyColor = "green";
              }
              {
                type = "wm";
                key = "  ";
                keyColor = "yellow";
              }
              {
                type = "terminal";
                key = "  ";
                keyColor = "yellow";
              }
              {
                type = "custom";
                format = "└────────────────────────────────────────────────────┘";
              }
              "break"
              {
                type = "title";
                key = "  ";
              }
              {
                type = "custom";
                format = "┌────────────────────────────────────────────────────┐";
              }
              {
                type = "cpu";
                format = "{1}";
                key = "  󱢋";
                keyColor = "blue";
              }
              {
                type = "gpu";
                format = "{2}";
                key = "  ";
                keyColor = "blue";
              }
              {
                type = "gpu";
                format = "{3}";
                key = "  󱄆";
                keyColor = "magenta";
              }
              {
                type = "memory";
                key = "  ";
                keyColor = "magenta";
              }
              {
                type = "custom";
                format = "└────────────────────────────────────────────────────┘";
              }
              "break"
              {
                type = "colors";
                padding.right = 2;
                symbol = "circle";
              }
              "break"
            ];
          };
        };

        starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            add_newline = true;
            scan_timeout = 10;
            format = lib.concatStrings [
              "[➜](bold green) $directory$c$rust$nix_shell$os"
              "$line_break"
              "$character"
            ];
            # format = lib.concatStrings [
            #   "╭───── $directory$c$rust$nix_shell$os"
            #   "$line_break"
            #   "╰──$character"
            # ];
            right_format = lib.concatStrings [
              "$git_branch$git_status"
            ];
            character = {
              success_symbol = "[↪](bold white)";
              error_symbol = "[↪](bold red)";
              vimcmd_symbol = "[󰕷](bold white)";
            };
            hostname = {
              ssh_only = false;
              format = lib.concatStrings [
                "[$hostname](bold green)"
              ];
            };
            username = {
              show_always = true;
              format = "[$user](bold green)";
            };
            os = {
              disabled = false;
              format = "[$symbol]($style)";
              style = "bold white";
            };
            git_branch = {
              symbol = " ";
              style = "bold purple";
              format = "[$symbol$branch]($style)";
            };
          };
        };

        kitty = {
          enable = true;
          shellIntegration.mode = "no-cursor";
          settings = {
            font_family = "AnkaCoder-r";
            italic_font = "AnkaCoder-i";
            bold_font = "AnkaCoder-b";
            bold_italic_font = "AnkaCoder-bi";
            font_size = "15.0";
            cursor_shape = "underline";
            cursor_blink_interval = "0";
            copy_on_select = "yes";
            remember_window_size = "no";
            initial_window_width = "1050";
            initial_window_height = "600";
            window_border_width = "0";
            window_padding_width = "15.0";
            confirm_os_window_close = "0";
          };
        };

        git = {
          enable = true;

          lfs = lib.enabled;

          settings = {
            user.name = lib.user.git_name;
            user.email = lib.user.git_email;
            alias = {
              # common aliases
              br = "branch";
              co = "checkout";
              st = "status";
              ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
              ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
              cm = "commit -m";
              dc = "diff --cached";
              amend = "commit --amend --no-edit";

              # aliases for submodule
              # update = "submodule update --init --recursive";
              # foreach = "submodule foreach";
            };
            pull.rebase = true;
          };

          # includes = [
          #   {
          #     # use diffrent email & name for work
          #     path = "~/work/.gitconfig";
          #     condition = "gitdir:~/work/";
          #   }
          # ];
        }; # git

        tmux = {
          enable = true;
          prefix = "C-a";
          extraConfig = ''
            set-option -g cursor-style underline
            set-option -g default-terminal "tmux-256color"
            set-option -ga update-environment TERM
            set-option -ga update-environment TERM_PROGRAM
            set-option -g allow-passthrough on
          '';

          plugins = with pkgs.tmuxPlugins; [
            nord
            vim-tmux-navigator
          ];
        }; # tmux
      }; # program
    };
  };
}
