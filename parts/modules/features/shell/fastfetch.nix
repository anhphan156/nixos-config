{ inputs, ... }: {
  flake.modules.nixos.shell =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        (symlinkJoin {
          name = "my-fastfetch";
          paths = [ fastfetch ];
          nativeBuildInputs = [ makeWrapper ];
          postBuild =
            let
              fastfetchConfig = writeText "my-fastfetch-config.jsonc" ''
                {
                  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
                  "display": {
                    "separator": "  "
                  },
                  "logo": {
                    "height": 18,
                    "source": "${inputs.dotfiles}/misc/wallpapers/fetch_logo/neofetch.jpg"
                  },
                  "modules": [
                    {
                      "format": "  コンピューター",
                      "outputColor": "red",
                      "type": "custom"
                    },
                    {
                      "format": "┌────────────────────────────────────────────────────┐",
                      "outputColor": "white",
                      "type": "custom"
                    },
                    {
                      "key": "  ",
                      "keyColor": "red",
                      "type": "os"
                    },
                    {
                      "key": "  ",
                      "keyColor": "red",
                      "type": "kernel"
                    },
                    {
                      "key": "  ",
                      "keyColor": "green",
                      "type": "packages"
                    },
                    {
                      "key": "  󰹑",
                      "keyColor": "green",
                      "type": "display"
                    },
                    {
                      "key": "  ",
                      "keyColor": "yellow",
                      "type": "wm"
                    },
                    {
                      "key": "  ",
                      "keyColor": "yellow",
                      "type": "terminal"
                    },
                    {
                      "format": "└────────────────────────────────────────────────────┘",
                      "type": "custom"
                    },
                    "break",
                    {
                      "key": "  ",
                      "type": "title"
                    },
                    {
                      "format": "┌────────────────────────────────────────────────────┐",
                      "type": "custom"
                    },
                    {
                      "format": "{1}",
                      "key": "  󱢋",
                      "keyColor": "blue",
                      "type": "cpu"
                    },
                    {
                      "format": "{2}",
                      "key": "  ",
                      "keyColor": "blue",
                      "type": "gpu"
                    },
                    {
                      "format": "{3}",
                      "key": "  󱄆",
                      "keyColor": "magenta",
                      "type": "gpu"
                    },
                    {
                      "key": "  ",
                      "keyColor": "magenta",
                      "type": "memory"
                    },
                    {
                      "format": "└────────────────────────────────────────────────────┘",
                      "type": "custom"
                    },
                    "break",
                    {
                      "padding": {
                        "right": 2
                      },
                      "symbol": "circle",
                      "type": "colors"
                    },
                    "break"
                  ]
                }
              '';
            in
            ''
              wrapProgram $out/bin/fastfetch \
                --add-flags "-c" \
                --add-flags "${fastfetchConfig}"
            '';
        })
      ];
    };
}
