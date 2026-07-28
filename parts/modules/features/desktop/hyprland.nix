{
  inputs,
  moduleWithSystem,
  ...
}: {
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
        package = self'.packages.hyprland;
      };
    };
  });

  perSystem = {pkgs, ...}: {
    packages.hyprland =
      (inputs.wrappers.wrapperModules.hyprland.apply {
        inherit pkgs;
        "hypr.conf".path = let
          hyprlandConfig = pkgs.writeText "hyprland.lua" ''
              ${builtins.readFile "${inputs.dotfiles}/config/hypr/hyprland.lua"}

            hl.monitor({
              output   = "eDP-1",
              mode     = "1920x1080",
              position = "0x0",
              scale    = "1.0",
            })

            for i = 1, 4 do
              hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
            end
          '';
        in
          hyprlandConfig;
      }).wrapper;
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
