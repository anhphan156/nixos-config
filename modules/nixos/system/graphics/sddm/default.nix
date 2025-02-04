{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.cyanea.graphical;
  randomBg = "/tmp/random.jpg";
in {
  options.cyanea.graphical.sddm = {
    autoLogin.enable = lib.mkOption {
      description = "enable auto login";
      type = lib.types.bool;
      default = true;
    };
    defaultSession = lib.mkOption {
      description = "sddm default session";
      type = lib.types.str;
      default =
        if cfg.awesome.enable
        then "none+awesome"
        else if cfg.xmonad.enable
        then "none+xmonad"
        else "hyprland";
    };
  };

  config = lib.mkIf cfg.gui.enable {
    systemd.services."sddm-random-background" = {
      script = ''
        base="${pkgs.wallpapers}/single"
        background=$(ls "$base" | shuf | head -1)
        cp $base/$background ${randomBg}
      '';
      before = ["display-manager.target"];
      after = ["network.target"];
      wantedBy = ["display-manager.target" "multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
      };
    };

    environment.systemPackages = [
      (pkgs.callPackage (inputs.self + /packages/sddm-astronaut-theme) {
        userTheme = {
          General = {
            HeaderText = "There is no place like ~/";
            Background = randomBg;
          };
        };
      })
    ];
    services.displayManager = {
      sddm.enable = true;
      sddm.package = pkgs.kdePackages.sddm;
      sddm.theme = "sddm-astronaut-theme";
      sddm.wayland.enable = cfg.hyprland.enable;
      sddm.extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
      ];
      inherit (cfg.sddm) defaultSession;
      autoLogin = {
        enable = cfg.sddm.autoLogin.enable;
        user = lib.user.name;
      };
    };
  };
}
