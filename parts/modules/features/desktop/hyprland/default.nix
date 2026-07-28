{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.hyprland = moduleWithSystem (
    { self', ... }:
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options = {
        hyprland = {
          extraConfig = lib.mkOption {
            type = lib.types.str;
            description = "hyprland extra config";
            default = "";
          };
        };
      };
      config = {
        environment.systemPackages = with pkgs; [
          brightnessctl
          wl-clipboard
          wtype
        ];
        programs.hyprland = {
          enable = true;
          package = self'.packages.hyprland.override { inherit (config.hyprland) extraConfig; };
        };
      };
    }
  );

  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    {
      packages.hyprland =
        let
          wrappedHyprland =
            {
              extraConfig ? "",
              writeText,
              ...
            }:
            (inputs.wrappers.wrapperModules.hyprland.apply {
              inherit pkgs;
              "hypr.conf".path =
                let
                  hyprlandConfig = writeText "hyprland.lua" ''
                    ${builtins.readFile "${inputs.dotfiles}/config/hypr/hyprland.lua"}
                    ${extraConfig}

                    hl.on("hyprland.start", function()
                      hl.exec_cmd("${lib.getExe self'.packages.noctalia}")
                    end)

                    hl.bind("ALT + SPACE", hl.dsp.exec_cmd("${lib.getExe self'.packages.noctalia} msg panel-toggle launcher"))
                    hl.bind("Print", hl.dsp.exec_cmd("${lib.getExe self'.packages.screenshotScript}"))
                  '';
                in
                hyprlandConfig;
            }).wrapper;
        in
        pkgs.callPackage wrappedHyprland { };

      packages.screenshotScript = pkgs.callPackage ./_packages/screenshotScript.nix {
        inherit (self'.packages) noctalia;
      };
    };
}
