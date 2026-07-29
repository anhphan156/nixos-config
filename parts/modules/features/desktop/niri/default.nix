{ inputs, moduleWithSystem, ... }: {

  flake.nixosModules.niri = moduleWithSystem (
    { self', ... }:
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {

      options.niri = {
        outputs = lib.mkOption {
          default = { };
          type = lib.types.attrs;
          description = "Output configuration";
        };
      };

      config = {
        environment.systemPackages = with pkgs; [
          xwayland-satellite
          brightnessctl
          wl-clipboard
          wtype
        ];
        programs.niri = {
          enable = true;
          package = self'.packages.niri.override {
            inherit (config.niri) outputs;
          };
        };
      };
    }
  );

  perSystem = { pkgs, self', ... }: {
    packages.niri = pkgs.callPackage (
      {
        outputs ? { },
        noctalia,
        screenshotScript,
        lib,
        ...
      }:
      (inputs.wrappers.wrapperModules.niri.apply {
        inherit pkgs;
        settings = {
          inherit outputs;
          binds = import ./_config/keybind.nix { inherit lib noctalia screenshotScript; };
          window-rules = import ./_config/window-rules.nix;

          spawn-at-startup = [
            "${lib.getExe noctalia}"
          ];

          layout = {
            gaps = 16;
            center-focused-column = "never";
            always-center-single-column = true;
            empty-workspace-above-first = false;
            focus-ring = {
              on = null;
              width = 5;
              active-color = "#cba6f7";
              inactive-color = "#9399b2";
              urgent-color = "#f38ba8";
            };
            border.off = null;
          };

          extraConfig = ''
            prefer-no-csd
            hotkey-overlay {
              skip-at-startup
            }
            input {
                focus-follows-mouse
                keyboard {
                    xkb {
                        layout "us"
                        options "compose:ralt,ctrl:nocaps"
                    }
                }
                touchpad {
                  tap
                  natural-scroll
                }
            }
          '';
        };
      }).wrapper
    ) { inherit (self'.packages) noctalia screenshotScript; };
  };
}
