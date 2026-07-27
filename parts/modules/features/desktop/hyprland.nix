{moduleWithSystem, ...}: {
  flake.nixosModules.hyprland = moduleWithSystem ({self', ...}: {
    lib,
    config,
    ...
  }: {
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
      programs.hyprland = {
        enable = true;
        package = self'.packages.hyprland.override {inherit (config.hyprland) extraConfig;};
      };
    };
  });

  perSystem = {pkgs, ...}: {
    packages.hyprland = pkgs.callPackage (
      {
        stdenv,
        hyprland,
        makeWrapper,
        extraConfig ? "",
        ...
      }:
        stdenv.mkDerivation {
          name = "wrapped-hyprland";

          nativeBuildInputs = [makeWrapper];

          dontUnpack = true;

          installPhase = ''
            cp -r ${hyprland} $out
            chmod -R u+w $out
            wrapProgram $out/bin/start-hyprland \
              --set HYPRLAND_CONFIG "${extraConfig}"
          '';

          meta.mainProgram = "Hyprland";
          passthru = {
            version = pkgs.hyprland.version;
            providedSessions = pkgs.hyprland.providedSessions;
          };
        }
    ) {};
  };
  # perSystem = {pkgs, ...}: {
  #   packages.hyprland = let
  #     mkHyprland = {extraConfig ? "", ...}:
  #       pkgs.symlinkJoin {
  #         name = "my-hyprland";
  #         nativeBuildInputs = [pkgs.makeWrapper];
  #         paths = [pkgs.hyprland];
  #         postBuild = let
  #           hyprlandConfig = pkgs.writeText "hyprland.lua" ''
  #             ${builtins.readFile "${inputs.dotfiles}/config/hypr/hyprland.lua"}
  #             ${extraConfig}
  #           '';
  #         in ''
  #           wrapProgram $out/bin/Hyprland \
  #             --add-flags "--config" \
  #             --add-flags "${hyprlandConfig}" \
  #         '';
  #         # meta.mainProgram = "Hyprland";
  #         passthru = {
  #           version = pkgs.hyprland.version;
  #           providedSessions = pkgs.hyprland.providedSessions;
  #         };
  #       };
  #   in
  #     pkgs.lib.makeOverridable mkHyprland {};
  # };
}
