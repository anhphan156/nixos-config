{
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    initExtra = lib.mkBefore ''
      fastfetch
    '';
  };

  programs.fastfetch = {
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
}
