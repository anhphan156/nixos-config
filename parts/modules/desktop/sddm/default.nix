{
  moduleWithSystem,
  inputs,
  ...
}:
let
  randomBg = "/tmp/random.jpg";
in
{
  flake.modules.nixos.sddm = moduleWithSystem (
    { self', ... }:
    {
      pkgs,
      config,
      ...
    }:
    {
      systemd.services."sddm-random-background" = {
        script = ''
          base="${inputs.dotfiles}/misc/wallpapers/single"
          background=$(ls "$base" | shuf | head -1)
          ln -sf $base/$background ${randomBg}
        '';
        before = [ "display-manager.target" ];
        after = [ "network.target" ];
        wantedBy = [
          "display-manager.target"
          "multi-user.target"
        ];
        serviceConfig = {
          Type = "oneshot";
        };
      };

      environment.systemPackages = [
        self'.packages.sddm-astronaut-theme
      ];

      services.displayManager = {
        sddm.enable = true;
        sddm.package = pkgs.kdePackages.sddm;
        sddm.theme = "sddm-astronaut-theme";
        sddm.wayland.enable = true;
        sddm.extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          kdePackages.qtsvg
          kdePackages.qtvirtualkeyboard
        ];
        defaultSession = "niri";
        autoLogin = {
          enable = false;
          user = config.username;
        };
      };
    }
  );

  perSystem = { pkgs, ... }: {
    packages.sddm-astronaut-theme = pkgs.callPackage ./_packages/sddmAstronautTheme.nix {
      userTheme = {
        General = {
          HeaderText = "There is no place like ~/";
          Background = randomBg;
        };
      };
    };
  };
}
