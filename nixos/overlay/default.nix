{ pkgs, ... }:
let
    overlay-awesome = final: prev: {
        awesome = prev.awesome.overrideAttrs (oa: {
            version = "14g9kp2x17fsx81lxfgl2gizwjwmfpsfqi5vdwv5iwa35v11dljn";
            src = pkgs.fetchFromGitHub {
                owner = "awesomeWM"; 
                repo = "awesome";
                rev = "8b1f8958b46b3e75618bc822d512bb4d449a89aa"; 
                sha256 = "0a140ixasiyzyr6axd5akjcgdgx58pn2kqdgy9ag6hczhpf7jrk4";
            };
            patches = [];
            postPatch = ''
                patchShebangs tests/examples/_postprocess.lua
            '';
        });
    };
    overlay-ncmpcpp = final : prev : {
        ncmpcpp = prev.ncmpcpp.override {
            visualizerSupport = true;
            clockSupport = true;
        };
    };
in
{
    nixpkgs.overlays = [
        overlay-awesome
        overlay-ncmpcpp
    ];
}
