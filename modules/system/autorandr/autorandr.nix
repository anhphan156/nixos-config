{
  user,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.isBacklight.enable {
    home-manager.users."${user.name}" = {
      services.autorandr.enable = true;
      programs.autorandr = {
        enable = true;
        profiles = {
          "laptop" = {
            fingerprint = {
              "eDP-1" = "00ffffffffffff0006af3d3200000000101c0104a51f117802fc15a055509b270c505400000001010101010101010101010101010101143780b87038244010103e0035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30332e32200a00bd";
              "HDMI-1" = "00ffffffffffff0052628888008888881c15010380060d780a0dc9a05747982712484c00000001010101010101010101010101010101a032386a407018802220e200428600000018350cf86a10e818302220e2003f7d00000018000000fc0053637265656e58706572742d0a000000fd00147801ff1d000a2020202020200026";
            };
            config = {
              "eDP-1" = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1080";
                #gamma = "1.0:0.909:0.833";
                rate = "60.00";
              };
              "HDMI-1" = {
                enable = false;
              };
            };
          };
        };
      };
    };
  };
}
