{
  flake.nixosModules.librewolf = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ librewolf ];
    systemd.tmpfiles.rules =
      let
        librewolfCfg = pkgs.writeText "librewolf-overrides-cfg" ''
          defaultPref("network.cookie.lifetimePolicy", 0);
          defaultPref("privacy.clearOnShutdown.cookies", false);
          defaultPref("privacy.clearOnShutdown.history", false);
          defaultPref("privacy.resistFingerprinting", false);
          defaultPref("webgl.disabled", false);
        '';
      in
      [
        "L+ /persistence/home/backspace/.config/librewolf/librewolf/librewolf.overrides.cfg - - - - ${librewolfCfg}"
      ];
  };
}
