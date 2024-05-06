{
    nixpkgs.overlays = [
        (final : prev : {
            ncmpcpp = prev.ncmpcpp.override {
                visualizerSupport = true;
                clockSupport = true;
            };
        })
        #(final : prev : {
        #    rofi = prev.rofi.overrideAttrs (old : {
        #        owner = "davatorium";
        #        repo = "rofi";
        #        rev = "5b9939b287b86255f9dcac1b10f3990b187875f9";
        #        hash = "0isyn58vcdvlibfxl61fjvh4ys0nfpwsdjz0a2322bglnp7yhnyf";
        #    });
        #})
        #(final : prev : {
        #    font-manager = prev.font-manager.overrideAttrs (old : {
        #        owner = "FontManager";
        #        repo = "font-manager";
        #        rev = "600f498946c3904064b4e4fdf96e5841f6a827e4";
        #        hash = "0qj14gbzjfba6kxs3n2jp19sidiiqw2rmsfwkz65hav2681c7rzf";
        #    });
        #})
    ];
}
